drop table sold_tickets;
drop table customer;
drop table movie;
drop table theater;

create table customer (
	cid integer,
	name char(255),
	age integer,
	primary key(cid)
);

create table movie (
	mid integer,
	title char(255),
	director char(255),
	genre char(255),
	minage integer,
	primary key(mid)
);

create table theater (
	postalcode char(255),
	address char(255),
	city_name char(255),
	revenue decimal(10,2),
	primary key(postalcode, address)
);

create table sold_tickets (
	cid integer,
	mid integer,
	postalcode char(255),
	address char(255),
	foreign key(cid) references customer,
	foreign key(mid) references movie,
	foreign key(postalcode, address) references theater,
	primary key(cid, mid, postalcode, address)
);

insert into customer values(1, 'Jan Diederik', 12);
insert into customer values(2, 'Laurentius Mens', 66);
insert into customer values(3, 'Gustaaf Windhove', 30);
insert into customer values(4, 'March van Veen', 18);
insert into customer values(5, 'Frederick Mens', 53);

insert into movie values (1, 'Lord of the jewellery', 'Pieter Jacques', 'fantasy', 12);
insert into movie values (2, 'The Revengers', 'Joshua Wheat', 'action', 8);
insert into movie values (3, 'Let it Flow', 'Wart Dipney', 'animation', 4);
insert into movie values (4, 'Me and you, Brute', 'Jules Kaiser', 'documentary', 16);
insert into movie values (5, 'The lake in the lady', 'Midday Shyamalalalan', 'thriller', 18);

insert into theater values ('3952GB', 'Weetniestraat 29', 'Leiden', 2000.50);
insert into theater values ('3952GB', 'Weetniestraat 30', 'Leiden', 1234.56);
insert into theater values ('8822TR', 'Inspiratielaan 91', 'Amsterdam', 2500.11);
insert into theater values ('3412EH', 'Kulzcynskistraat 1', 'Rotterdam', 2201.03);
insert into theater values ('6969NS', 'Partylaan 420', 'Sexbierum', 10.32);

insert into sold_tickets values (1,5, '3412EH', 'Kulzcynskistraat 1');
insert into sold_tickets values (2,1, '3952GB', 'Weetniestraat 29');
insert into sold_tickets values (2,2, '3952GB', 'Weetniestraat 29');
insert into sold_tickets values (2,3, '3952GB', 'Weetniestraat 29');
insert into sold_tickets values (2,4, '3952GB', 'Weetniestraat 29');
insert into sold_tickets values (2,5, '6969NS', 'Partylaan 420');
insert into sold_tickets values (4,2, '8822TR', 'Inspiratielaan 91');
insert into sold_tickets values (5,1, '3952GB', 'Weetniestraat 30');
insert into sold_tickets values (5,2, '3952GB', 'Weetniestraat 30');
insert into sold_tickets values (4,2, '3952GB', 'Weetniestraat 30');
