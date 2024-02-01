--1. List all customers who live in Texas (use JOINs)_________________________________________________________________________________

select *
from address
where district = 'Texas';

select customer.first_name, customer.last_name, address.district, country.country
from customer
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
where address.district = 'Texas';

--Answer: 5 People-
--Richard Mccrary, Texas, United States
--Bryan Hardison, Texas, United States
--Ian Still, Texas, United States
--Kim Cruz, Texas, United States
--Jennifer Davis, Texas, United States--

--2. Get all payments above $6.99 with the Customer's Full Name_______________________________________________________________________

select customer.first_name, customer.last_name, payment.amount
from customer
join payment on customer.customer_id = payment.customer_id
where payment.amount > 6.99
order by payment.amount desc;

--Answer: 1406 Payments With Full Names

--3. Show all customers names who have made payments over $175(use subqueries)_________________________________________________________

select * 
from customer
where customer_id in (
select customer_id
from payment
group by customer_id
having sum(amount) > 175
order by sum(amount) desc
);

--Answer: 
--6 Customers - 
--Rhonda Kennedy
--Clara Shaw
--Eleanor Hunt
--Marion Snyder
--Tommy Collazo
--Karl Seal

--4. List all customers that live in Nepal (use the city table)_________________________________________________________________________

select customer.first_name, customer.last_name, country.country
from customer
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
where country.country = 'Nepal';

--Answer: 1 Customer Kevin	Schuler	that lives in Nepal

--5. Which staff member had the most transactions?______________________________________________________________________________________

select staff.staff_id, staff.first_name, staff.last_name, count(payment.payment_id) as badass_employee
from staff
join payment on staff.staff_id = payment.staff_id
group by staff.staff_id, staff.first_name, staff.last_name
order by badass_employee desc
limit 1;

--Answer: Jon Stephens with 7,304 transactions! #Badass_Employee

--6. How many movies of each rating are there?____________________________________________________________________________________________

select rating, count(film_id) as movie_count
from film
group by rating;

--Answer:
-- G     -  178
-- PG    -  194
-- PG-13 -  223
-- R     -  195
-- NC-17 -  210

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)___________________________________________________________

select 
customer.first_name,
customer.last_name,
miracle_query.amount,
miracle_query.under_6_99 from 
customer join (select 
payment.customer_id, 
max(payment.amount) as amount,
count(payment.payment_id) as under_6_99
from payment
where payment.amount > 6.99
group by payment.customer_id
having count(payment.payment_id) = 1) 
as miracle_query 
on customer.customer_id = miracle_query.customer_id;

--Answer: 130 Customers Paid Under $6.99 Within a Single Transaction!

--8. How many free rentals did our stores give away?___________________________________________________________________________________________
-------------------------
select payment_id, amount
from payment
where amount = 0;
-------------------------
select payment.payment_id, payment.amount, customer.first_name, customer.last_name
from payment
join customer on payment.customer_id = customer.customer_id
where payment.amount = 0;
-------------------------

--Answer: 24 Customers Paid $0 for their rentals













