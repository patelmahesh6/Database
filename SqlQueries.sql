SELECT * FROM  customer; 
select customer_id, first_name ,last_name  from customer;
select customer_id, first_name ,last_name  from customer  order by first_name ,last_name;
select * from  customer where store_id = 2 and active = 1 and not address_id = 8 ;
select * from  customer where first_name like 'A%' or first_name like '%B' order by first_name desc ,last_name asc;
select * from customer where first_name like 'A_%B%';
select * from customer where last_name  like 'P_T_E%';


update customer  set email = null ,last_name = 'PATEL' where customer_id in ( 573, 400);

select * from customer where email is null;
select * from customer where email is not null;

/* insert into customer() values (); */

select * from payment where amount > 2 limit 3;

select CONCAT( cust.first_name,' ', cust.last_name ) as name, min(pay.amount) as amount  from payment pay 
inner join customer cust on  cust.customer_id = pay.customer_id ;

select max(amount) from payment;
select avg(amount) from payment;
select count(amount) from payment where amount < 3;
select sum(amount) from payment;
select * from payment where amount between 1 and 3 order by amount;
select * from payment where amount not  between 2 and 3 order by amount;

select * from payment where customer_id not in (select customer_id from customer);

select   cust.customer_id  , sum(pay.amount) as total   from customer cust 
inner join payment pay 
where pay.customer_id = cust.customer_id 
group by cust.customer_id;

select cust.customer_id  , cust.last_name ,act.actor_id ,act.last_name from  customer cust
left join actor act on act.last_name = cust.last_name order by customer_id;

select cust.customer_id  , cust.last_name ,act.actor_id ,act.last_name from  customer cust
right join actor act on act.last_name = cust.last_name order by act.actor_id;

select a.customer_id  , concat(a.first_name ,' ',a.last_name) as a  ,b.customer_id , concat(b.first_name ,' ',b.last_name) as b from  customer a 
inner join customer b on a.first_name = b.last_name order by a.customer_id; 


SELECT first_name FROM customer WHERE first_name like 'A%'
UNION ALL
SELECT first_name FROM actor WHERE first_name like 'A%'
ORDER BY first_name;

SELECT first_name FROM customer WHERE first_name like 'A%'
UNION
SELECT first_name FROM actor WHERE first_name like 'A%'
ORDER BY first_name;


/*
Exists
ANY 
ANY ALL
*/

INSERT INTO customersBackup2017 
select *  FROM customer;




