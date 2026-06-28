create table books (book_id int primary key, title varchar (255), author varchar (255), price decimal(10, 2)
 );
create table customers (customer_id int primary key, name varchar(255), email varchar(255), address varchar(255)
);
create table orders (order_id int primary key, customer_id int, book_id int, quantity int, order_date date, foreign key (customer_id) references customers(customer_id), foreign key (book_id) references orders (order_id)
);
create table payments (payment_id int primary key, order_id int, payment_date date, amount decimal (10,2), foreign key (order_id) references orders(order_id)
);
insert into books values
(1, 'book 1', 'author 1', 10.99), (2, 'book 2', 'author 2', 12.99), (3, 'book 3', 'author 3', 9.99), (4,'book 4', 'author 4', 15.99), (5, 'book 5', 'author 5', 8.99);
insert into customers values
(1, 'customer 1', 'customer1@example.com', 'address 1'), (2, 'customer 2', 'customer2@example.com', 'address 2'),(3, 'customer 3', 'customer3@example.com', 'address 3'),(4, 'customer 4', 'customer4@example.com', 'address 4'),(5, 'customer 5', 'customer5@example.com', 'address 5');
insert into orders values
(1,1,1,2, '2023-06-01'), (2,2,3,1, '2023-06-02'), (3,3,2,3, '2023-06-03'), (4,4,4,2, '2023-06-04'), (5,5,5,1, '2023-06-05');
insert into payments values
(1,1, '2023-06-02', 21.98), (2,2, '2023-06-03', 9.99), (3,3, '2023-06-04', 38.97), (4,4, '2023-06-05', 31.98), (5,5, '2023-06-06', 8.99);

use test_schema;

set foreign_key_checks = 0;

drop table if exists payments;
drop table if exists orders;
drop table if exists customers;
drop table if exists books;

set foreign_key_checks = 1;

use book_store;

-- Retrieve the details of the cutomers
select * from customers;

-- Retrieve the title and authors of all books
select title, author from books;

-- Retrieve the total number of books sold
select sum(quantity) from orders;

-- Show the names of all the customers who have placed orders
select distinct name from customers c join orders o ON c.customer_id = o.customer_id;

-- What is the total revenue generated from book sales
select sum(amount) from payments;

-- Which customer made the highest payment
select name from customers c join orders o on c.customer_id = o.customer_id join payments p on o.order_id = p.order_id order by amount desc limit 1;

-- Which book has the highest price?
select title from books order by price desc limit 1;

-- How many books were sold to each customer?
select c.name, sum(o.quantity) from customers c left join orders o on c.customer_id = o.customer_id group by c.name;

-- Which customer has made the most orders?
select name from customers c join orders o on c.customer_id = o.customer_id group by name order by count(o.order_id) desc limit 1;

-- Show the names of customers who have not placed any orders
select name from customers c left join orders o on c.customer_id = o.customer_id where o.order_id is null;