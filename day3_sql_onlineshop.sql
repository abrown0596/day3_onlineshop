create database onlineshop;
use onlineshop;

#2 Create 4 table and add 5 records to each, updating 2 in each.

create table users (
userid int auto_increment,
forename varchar(100) not null,
surname varchar(100) not null,
email varchar(150) unique not null,
address varchar(200) not null,
primary key (userid)
);

create table products (
productid int auto_increment,
name varchar(100) not null,
categoryid int,
price float not null,
primary key(productid)
);

create table orders (
orderid int auto_increment,
userid int not null,
orderdate date not null,
primary key(orderid),
foreign key(userid) references users(userid)
);

create table orderline (
orderlineid int auto_increment,
orderid int not null,
productid int not null,
qty int not null,
ordervalue int not null,
primary key(orderlineid),
foreign key(orderid) references orders(orderid),
foreign key(productid) references products(productid)
);

describe orderline;

insert into users (forename,surname,email,address)
values ('nick', 'cage', 'ncage@mail.com','10 national treasure road, IL76 NYC'),
('alex','hamilton','tomcat@mail.com','1776 nyc, ny20 irl'),
('aron','burr','sir@mail.com','next door sh18 0ot'),
('name','here','email@mail.com', 'board street'),
('trevor','belmont','vslay@mail.com','belmont hold');

insert into products (name,categoryid,price)
values ('double bed',101,99.99),
('patio set',103,54.99),
('lava lamp',102,14.99),
('double mattress',101,79.99),
('desk lamp',102,19.99);

insert into orders (userid,orderdate)
values(5,'2021-12-20'),
(1,'2022-01-19'),
(2,'2021-11-23'),
(4,'2021-12-26'),
(3,'2022-01-01');

insert into orderline (orderid,productid,qty,ordervalue)
values (1,4,2,158.99),
(2,5,1,19.99),
(2,3,1,14.99),
(3,1,1,99.99),
(4,2,1,54.99),
(5,3,2,29.98);

update users
set forename = 'nicholas'
where userid =1;

update users
set forename = 'Adam'
where forename like 'A%';

update products
set name = 'single bed'
where productid = 1;

update products
set name = 'single mattress'
where productid = 4;

update orders
set orderdate = '2021-01-19'
where userid > 4;

update orderline 
set qty = 3
where orderid = 2;


#3 Query your database (at least 10 different queries).

#q1
select * from users
where forename like 'a%';

#q2
select name, price from products
order by price desc limit 3;

#q3
select count(orderid) from orders
where orderdate >= '2022-01-01';

#q4
select u.surname,o.orderdate
from orders o
join users u
on o.userid = u.userid
order by surname asc;

#q5
select avg(price) from products
where categoryid = 101;

#q6
select ol.orderlineid, u.surname, p.name, ol.qty, ol.ordervalue, o.orderdate
from orderline ol
join orders o
on ol.orderid=o.orderid
join users u
on o.userid=u.userid
join products p
on ol.productid = p.productid;

#q7
select sum(qty),sum(ordervalue) from orderline;

#q8
create view Average_Sell_Price_of_ALL_Orders as
select avg(qty),avg(ordervalue), sum(ordervalue)/sum(qty) as 'ASP of all orders' 
from orderline;

#q9
select * from Average_Sell_Price_of_ALL_Orders;

#q10
select ol.orderlineid, p.name, p.categoryid, qty, ordervalue, o.orderdate, u.address
from orderline ol
join products p 
on ol.productid = p.productid
join orders o
on ol.orderid = o.orderid
join users u 
on o.userid = u.userid
where o.orderdate < '2022-01-01'
order by ordervalue desc;

#4 Delete one record per table. Make sure you don't delete all of them by accident!

delete from users where forename like '%i%';
delete from products where productid = 5;
delete from orders where orderdate = '2022-01-19';
delete from orderline where orderid =2;

#5 STRETCH GOAL: Try to add one more table to your diagram and then to your database. It should be called 'Reviews'

create table reviews (
reviewid int auto_increment,
productid int not null,
userid int not null,
stars int not null,
description varchar(250),
primary key(reviewid),
foreign key(userid) references users(userid),
foreign key(productid) references products(productid)
);

insert into reviews (productid,userid,stars,description)
values (4,5,2,'bumpy mattress but it will do');

#--------------------------------------
SET SQL_SAFE_UPDATES=0;

set foreign_key_checks=0;

select * from users;
select * from products;
select * from orders;
select * from orderline;
select * from reviews;





drop table users;
drop table products;
drop table orders;
drop table orderline;
drop table reviews;
