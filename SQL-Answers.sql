/* Question: 1  What will be the result of the query below?
SELECT * FROM runners WHERE id NOT IN (SELECT winner_id FROM races)
Explain your answer and also provide an alternative version of this query that 
will avoid the issue that it exposes. */

use test;

create table runners(
id int,
r_name varchar(20),
primary key(id));

insert into runners values(1,'John Doe');
insert into runners values(2,'Jane Doe');
insert into runners values(3,'Alice Jones');
insert into runners values(4,'Bobby Louis');
insert into runners values(5,'Lisa Romero');

create table races(
event_id int,
event_name varchar(30),
winner_id int);

insert into races  values(1,'100 meter dash',2);
insert into races  values(2,'500 meter dash',3);
insert into races  values(3,'cross-country',2);
insert into races  values(4,'triathalon',NULL);

SELECT * FROM runners WHERE id NOT IN (SELECT winner_id FROM races);
 
 output : NULL NULL
 
ALTERNATE VERSON : 
 
SELECT id,r_name,event_name FROM runners 
LEFT JOIN races
ON races.winner_id=runners.id
WHERE races.winner_id IS NOT NULL;

/* Question: 2 Write a query to fetch values in table test_a that are and not in test_b without using the NOT keyword. */

create table test_a(id int);

insert into test_a values(10);
insert into test_a values(20);
insert into test_a values(30);
insert into test_a values(40);
insert into test_a values(50);

create table test_b(id int);

insert into test_b values(10);
insert into test_b values(30);
insert into test_b values(50);

SELECT * FROM test_a
LEFT JOIN
test_b 
ON (test_a.id = test_b.id)
WHERE test_b.id IS NULL;

/* Question: 3 Write a query to to get the list of users who took the a training lesson more than once in the same day, 
grouped by user and training lesson, each ordered from the most recent lesson date to oldest date. */

create table users(
user_id int,
user_name varchar(30),
primary key(user_id));

insert into users values(1,'John Doe');
insert into users values(2,'Jane Don');
insert into users values(3,'Alice Jones');
insert into users values(4,'Lisa Romero');

create table training_details(
user_training_id int,
user_id int,
training_id int,
training_date date,
primary key(user_training_id ),
foreign key (user_id) references users(user_id));

insert into training_details values(1,1,1,'2015-08-02');
insert into training_details values(2,2,1,'2015-08-03');
insert into training_details values(3,3,2,'2015-08-02');
insert into training_details values(4,4,2,'2015-08-04');
insert into training_details values(5,2,2,'2015-08-03');
insert into training_details values(6,1,1,'2015-08-02');
insert into training_details values(7,3,2,'2015-08-04');
insert into training_details values(8,4,3,'2015-08-03');
insert into training_details values(9,1,4,'2015-08-03');
insert into training_details values(10,3,1,'2015-08-02');
insert into training_details values(11,4,2,'2015-08-04');
insert into training_details values(12,3,2,'2015-08-02');
insert into training_details values(13,1,1,'2015-08-02');
insert into training_details values(14,4,3,'2015-08-02');

SELECT u.user_name,t.training_date,COUNT(t.training_id) FROM users u
INNER JOIN 
training_details t
ON
(u.user_id = t.user_id)
GROUP BY user_name,training_date
HAVING COUNT(*) > 1
ORDER BY user_name,training_date DESC;

/*Question: 4 - Write a query to generate below output */

create table employee(
emp_id int,
e_name varchar(20),
salaray int,
manager_id int,
primary key(emp_id));

insert into employee values(10,'Anil',50000,18);
insert into employee values(11,'Vikas',75000,16);
insert into employee values(12,'Nisha',40000,18);
insert into employee values(13,'Nidhi',60000,17);
insert into employee values(14,'Priya',80000,18);
insert into employee values(15,'Mohit',45000,18);
insert into employee values(16,'Rajesh',90000,NULL);
insert into employee values(17,'Raman',55000,16);
insert into employee values(18,'Santosh',65000,17);

SELECT E2.emp_id AS "Manager_Id,",E2.e_name as "Manager",AVG(E1.salaray) FROM employee E1,employee E2
WHERE E1.manager_id = E2.emp_id
GROUP BY E2.emp_id,E2.e_name
ORDER BY E2.emp_id;

