drop table items;
drop table orders;
drop table coupons;
drop table order_contains;

create table items (
  iid integer,
  name char(255),
  price decimal(10, 2),
  description clob,
  primary key(iid)
);

create table orders (
  oid integer,
  status char(20),
  total_cost decimal(10, 2),
  primary key(oid)
);

create table order_contains (
  oid integer,
  iid integer,
  primary key(oid, iid)
);

create table coupons (
  code char(20),
  valid_from date,
  valid_to date,
  discount_percentage integer,
  primary key(code)
);
