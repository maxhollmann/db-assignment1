create table items (
  iid integer,
  name char(255) not null,
  price decimal(10, 2) not null,
  description clob,
  primary key (iid)
);

create table coupons (
  code char(20),
  valid_from date not null,
  valid_to date not null,
  discount_percentage integer not null,
  primary key (code)
);

create table customers (
  cid integer,
  primary key (cid)
);
create table guest_customers (
  cid integer,
  session_id integer not null,
  primary key (cid),
  foreign key (cid) references customers on delete cascade
);
create table registered_customers (
  cid integer,
  username char(20) not null,
  password_hash char(256) not null,
  points integer default 0 not null,
  primary key (cid),
  foreign key (cid) references customers on delete cascade
);

create view full_customers as
  select c.cid, g.session_id, r.username, r.password_hash, r.points
  from customers c
  left outer join guest_customers g on g.cid = c.cid
  left outer join registered_customers r on r.cid = c.cid;

create trigger T_AFTER_INSERT_GUEST
after insert on guest_customers
for each row begin
  delete from registered_customers c where c.cid = :new.cid;
end;
/

create trigger T_AFTER_INSERT_REGISTERED
after insert on registered_customers
for each row begin
  delete from guest_customers c where c.cid = :new.cid;
end;
/


create table addresses (
  postal_code char(6),
  house_number char(10),
  street_name char(30) not null,
  city char(30) not null,
  telephone_number char(15),
  cid integer not null,
  primary key (cid, postal_code, house_number),
  foreign key (cid) references customers on delete cascade
);

create table orders (
  oid integer,
  cid integer not null,
  order_date date default sysdate not null,
  postal_code char(6) not null,
  house_number char(10) not null,
  status char(20) not null,
  total_cost decimal(10, 2) not null,
  coupon_code char(20),
  primary key (oid),
  foreign key (coupon_code) references coupons,
  foreign key (cid) references customers,
  foreign key (cid, postal_code, house_number) references addresses
);

create table ordered_items (
  oid integer,
  iid integer,
  primary key (oid, iid)
);
