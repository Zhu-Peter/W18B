-- Create a DB with the following structure and relationships:

-- customer:
--  username (unique)
--  password
-- created_at
-- id (PK)

-- item:
-- name
-- price
-- id (PK)

-- purchase:
-- purchase_time 
-- Make this a datetime, as we will assume that any purchase with the same customer_id and purchase_time are part of a single 'order'
-- customer_id (FK)
-- item_id (FK)
-- id (PK)

create table customers (
    username varchar(255) not null unique,
    password varchar(255) not null,
    created_at time not null,
    id int primary key auto_increment);

create table item (
    name varchar(255) not null,
    price decimal(10,2) not null,
    id int primary key auto_increment);

create table purchase (
    customer_id int not null,
    item_id int not null,
    purchase_time datetime not null,
    id int primary key auto_increment,
    foreign key (customer_id) references customers(id),
    foreign key (item_id) references item(id));

-- Create an INSERT statement that will create at least 5 customers
-- Create an INSERT statement that will create at least 10 items
-- Create an INSERT statement that will create at least 20 purchases

insert into customers (username, password, created_at) values 
('John', 'john123', 2022-01-01),
('Jane', 'jane234', 2023-01-01),
('Jessica', 'jess567', 2024-01-01),
('Joseph', 'joe555', 2024-02-01),
('Jack', 'pass', 2024-03-01);

insert into item (name, price) values
('Apple', 10.50),
('Banana', 2.40),
('Orange', 1.20),
('Grapes', 1.50),
('Pineapple', 5.20),
('Strawberry', 3.20),
('Watermelon', 10.20),
('Cherry', 4.20),
('Mango', 5.20),
('Papaya', 2.20);

insert into purchase (customer_id, item_id, purchase_time) values
(1, 1, '2024-06-27 18:06:41.316'),
(1, 2, '2024-06-27 18:06:41.316'),
(1, 3, '2024-06-27 18:06:41.316'),
(1, 4, '2024-06-27 18:06:41.316'),
(2, 5, '2024-04-27 05:06:41.316'),
(2, 6, '2024-04-27 05:06:41.316'),
(2, 7, '2024-04-27 05:06:41.316'),
(2, 8, '2024-04-27 05:06:41.316'),
(3, 9, '2024-05-21 02:06:41.316'),
(3, 10, '2024-05-21 02:06:41.316'),
(3, 1, '2024-05-21 02:06:41.316'),
(3, 2, '2024-05-21 02:06:41.316'),
(3, 2, '2024-07-21 01:16:41.316'),
(3, 2, '2024-07-21 01:16:41.316'),
(4, 1, '2024-01-21 01:06:41.316'),
(4, 2, '2024-01-21 01:06:41.316'),
(4, 3, '2024-01-21 01:06:41.316'),
(4, 4, '2024-01-21 01:06:41.316'),
(5, 1, '2024-02-21 01:06:41.316'),
(5, 2, '2024-02-21 01:06:41.316'),
(5, 3, '2024-02-21 01:06:41.316');

-- Write a SELECT statement that will return the 5 most recent purchases
-- Return the customer username, item name and purchase time
-- Convert the SELECT statement into a stored procedure called five_recent_purchases
-- Write the proper CALL query in your console

select username, item.name, purchase_time from purchase 
join item on purchase.item_id = item.id
join customers on purchase.customer_id = customers.id
order by purchase_time desc
limit 5;

create procedure five_recent_purchases()
begin
    select username, item.name, purchase_time from purchase 
    join item on purchase.item_id = item.id
    join customers on purchase.customer_id = customers.id
    order by purchase_time desc
    limit 5;
end;

-- Write a SELECT statement that will return the username and count of purchases made by each customer 
-- Convert the SELECT statement into a stored procedure called customer_purchases.
-- Allow this stored procedure to take 1 argument, a customer_id
-- Modify the SELECT statement you wrote before to now only return the username and count of purchases made by the customer with the id that is given when called
-- Write the proper CALL query in your console for 3 different customers

select username, count(purchase.id) from purchase 
join customers on purchase.customer_id = customers.id
group by username;

create procedure customer_purchases(customer_id int)
begin
    select username, count(purchase.id) from purchase 
    join customers on purchase.customer_id = customers.id
    where customers.id = customer_id
    group by username;
end;

-- Write a SELECT query that will return the total amount of money a customer has spent on all purchases
-- Convert the SELECT statement into a stored procedure
-- Allow this stored procedure to take 1 argument, a date
-- Modify the SELECT statement you wrote before to only include purchases made after the given date for the total
-- Write the proper CALL query in your console for 3 different purchase dates

select username, sum(item.price) from purchase
join customers on purchase.customer_id = customers.id
join item on purchase.item_id = item.id
group by username;

create procedure customer_purchases_after_date(date date)
begin
    select username, sum(item.price) from purchase
    join customers on purchase.customer_id = customers.id
    join item on purchase.item_id = item.id
    where purchase.purchase_date > date
    group by username;
end;

-- Write a SELECT query that will return the average amount of money a customer has spent on all purchases
-- Convert the SELECT statement into a stored procedure 
-- Allow this stored procedure to take 2 arguments, a date and customer id
-- Modify the SELECT statement you wrote before to only include purchases made after the given date and by the specified customer for the average
-- Write the proper CALL query in your console for 3 different purchase dates and customers

select username, avg(item.price) from purchase
join customers on purchase.customer_id = customers.id
join item on purchase.item_id = item.id
group by username;

create procedure avg_purchase_date(date date, customer_id int)
begin
    select username, avg(item.price) from purchase
    join customers on purchase.customer_id = customers.id
    join item on purchase.item_id = item.id
    where purchase.purchase_date > date and purchase.customer_id = customer_id
    group by username;
end;

