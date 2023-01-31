-- 1. List all customers who live in Texas (USE JOINS) ANSWER: 5 customers

select * from customer;  -- Customer = table A

select * from address
where district like 'Texas';  -- address = table B

select customer_id, district
from customer
inner join address
on customer.address_id = address.address_id
where district like 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name ANSWER: 2013 total payments

select * from payment;

select * from customer;
select sum(amount) ,first_name, last_name
from payment
full join customer
on payment.customer_id = customer.customer_id
group by amount, first_name, last_name
having amount > 6.99
order by first_name, last_name desc;

-- Checking my work

select sum(amount), first_name
from payment
full join customer
on payment.customer_id = customer.customer_id
group by amount, first_name
having amount > 6.99 and first_name = 'Harold';


-- 3. Show all customers names who have made payments over $175 ( use subqueries) ANSWER: Peter Menard

select * from customer;

select * from payment;
select first_name, last_name , store_id
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id, amount
	having amount > 175
	order by amount
)
group by first_name, last_name, store_id;

-- Checking my work

select first_name, last_name, amount
from customer
full join payment
on customer.customer_id = payment.customer_id
where amount >= 175
group by first_name, last_name, amount;

-- 4. List all customers that live in Nepal (use the city table) Kevin Schuler

select * from city;

select * from customer;

select * from country;

select * from address;

select first_name, last_name, country
from customer
inner join address
on customer.address_id = address.address_id
inner join city
on address.city_id = city.city_id
inner join country
on city.country_id = country.country_id
group by first_name, last_name, country
having country = 'Nepal';

-- 5. Which staff member had the most transactions? ANSWER: Jon Stephens

select * from payment;

select * from staff;

select first_name, last_name, count(payment_id)
from staff
inner join payment
on staff.staff_id = payment.staff_id
group by first_name, last_name;

-- 6. How many movies of each rating are there? ANSWER: see query

select count(distinct rating) as movie_rating, rating, count(title)
from film
group by rating;

-- Checking my work

select rating, title
from film
where rating is null;

-- 7. Show all customers who have made a single payment above $6.99 (USE SUBQUERIES) ANSWER: 597 different customers

select * from payment;
select * from customer;

select store_id, first_name, last_name
from customer
where customer_id in
(	select customer_id
	from payment
	group by customer_id, amount
	having amount > 6.99
)
group by store_id, first_name, last_name
order by  first_name, last_name desc;

--Checking work by checking last names to see if above 6.99

select sum(amount) ,first_name, last_name
from payment
full join customer
on payment.customer_id = customer.customer_id
group by amount, first_name, last_name
having amount > 6.99 and last_name = 'Fennell'
order by first_name, last_name desc;

-- 8. How many free rentals did our stores give away? ANSWER: NONE

select * from rental;

select * from payment;

select *
from payment
where amount = 0;

