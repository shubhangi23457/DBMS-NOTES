/*
========================================================
        DML + BASIC SQL QUERYING
========================================================

TOPICS:
1. INSERT
2. UPDATE
3. DELETE
4. SELECT
5. WHERE
6. ORDER BY
7. DISTINCT
8. LIMIT

========================================================
1. DML COMMANDS
========================================================

DML = Data Manipulation Language

DML is used to manipulate the data stored inside
database tables.

Main DML commands:

INSERT  -> Add new records
UPDATE  -> Modify existing records
DELETE  -> Remove records

NOTE:
SELECT is generally classified as DQL
(Data Query Language), but it is commonly studied
along with DML and basic querying.

========================================================
2. INSERT
========================================================

INSERT is used to add new rows into a table.

Syntax:

INSERT INTO table_name
VALUES (value1, value2, ...);

OR

INSERT INTO table_name (column1, column2)
VALUES (value1, value2);

Multiple rows:

INSERT INTO table_name (columns)
VALUES
(value1, value2),
(value1, value2);

========================================================
3. UPDATE
========================================================

UPDATE modifies existing records.

Syntax:

UPDATE table_name
SET column = new_value
WHERE condition;

IMPORTANT:
Always use WHERE when updating specific records.

Without WHERE, ALL rows are updated.

========================================================
4. DELETE
========================================================

DELETE removes records from a table.

Syntax:

DELETE FROM table_name
WHERE condition;

IMPORTANT:
DELETE without WHERE removes ALL rows.

========================================================
5. SELECT
========================================================

SELECT is used to retrieve data from a table.

All columns:

SELECT *
FROM table_name;

Specific columns:

SELECT column1, column2
FROM table_name;

========================================================
6. WHERE
========================================================

WHERE is used to filter records.

Syntax:

SELECT *
FROM table_name
WHERE condition;

Common operators:

=    Equal
<>   Not equal
!=   Not equal
>    Greater than
<    Less than
>=   Greater than or equal
<=   Less than or equal

Logical operators:

AND
OR
NOT

Other operators:

BETWEEN
IN
LIKE
IS NULL
IS NOT NULL

Examples:

WHERE marks > 80
WHERE department = 'CSE'
WHERE age BETWEEN 18 AND 22
WHERE department IN ('CSE', 'ECE')
WHERE name LIKE 'A%'

========================================================
7. ORDER BY
========================================================

ORDER BY sorts the result.

Ascending:

ORDER BY column ASC;

Descending:

ORDER BY column DESC;

ASC is the default.

Example:

SELECT *
FROM Student
ORDER BY marks DESC;

Multiple columns:

ORDER BY department ASC, marks DESC;

========================================================
8. DISTINCT
========================================================

DISTINCT removes duplicate values from the result.

Syntax:

SELECT DISTINCT column
FROM table_name;

Example:

SELECT DISTINCT department
FROM Student;

If department values are:

CSE
CSE
ECE
ECE
ME

DISTINCT returns:

CSE
ECE
ME

========================================================
9. LIMIT
========================================================

LIMIT restricts the number of rows returned.

Syntax:

SELECT *
FROM Student
LIMIT 5;

Returns only the first 5 rows.

Very commonly used with ORDER BY:

SELECT *
FROM Student
ORDER BY marks DESC
LIMIT 3;

This gives the TOP 3 students.

========================================================
10. LIMIT + OFFSET
========================================================

Syntax:

LIMIT offset, count;

Example:

LIMIT 2, 3;

Means:

Skip first 2 rows
Return next 3 rows

Alternative:

LIMIT 3 OFFSET 2;

========================================================
11. IMPORTANT DIFFERENCES
========================================================

DELETE:
- Removes rows
- WHERE can be used
- Can remove selected rows

TRUNCATE:
- Removes all rows
- WHERE cannot be used
- Table structure remains

DROP:
- Removes the entire table/database object

========================================================
12. QUICK REVISION
========================================================

INSERT   = ADD
UPDATE   = MODIFY
DELETE   = REMOVE
SELECT   = DISPLAY
WHERE    = FILTER
ORDER BY = SORT
DISTINCT = REMOVE DUPLICATES
LIMIT    = RESTRICT ROWS

========================================================
                  RUNNABLE SQL
========================================================
*/

CREATE DATABASE DML_Practice;

USE DML_Practice;

CREATE TABLE Student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department VARCHAR(20),
    marks INT
);


/*
========================================================
                    INSERT
========================================================
*/

-- Insert one record

INSERT INTO Student
(id, name, age, department, marks)
VALUES
(1, 'Rahul', 20, 'CSE', 85);


-- Insert multiple records

INSERT INTO Student
(id, name, age, department, marks)
VALUES
(2, 'Priya', 21, 'ECE', 92),
(3, 'Aman', 19, 'CSE', 78),
(4, 'Neha', 22, 'ME', 88),
(5, 'Riya', 20, 'CSE', 95),
(6, 'Karan', 21, 'ECE', 72),
(7, 'Anjali', 19, 'ME', 90),
(8, 'Arjun', 23, 'CSE', 95);


/*
========================================================
                    SELECT
========================================================
*/

-- Display all students

SELECT *
FROM Student;


-- Display only name and marks

SELECT name, marks
FROM Student;


/*
========================================================
                    WHERE
========================================================
*/

-- Marks greater than 80

SELECT *
FROM Student
WHERE marks > 80;


-- Students from CSE

SELECT *
FROM Student
WHERE department = 'CSE';


-- Age greater than or equal to 20

SELECT *
FROM Student
WHERE age >= 20;


-- CSE students with marks above 80

SELECT *
FROM Student
WHERE department = 'CSE'
AND marks > 80;


-- CSE or ECE students

SELECT *
FROM Student
WHERE department = 'CSE'
OR department = 'ECE';


-- Marks between 80 and 90

SELECT *
FROM Student
WHERE marks BETWEEN 80 AND 90;


-- Students from CSE or ECE

SELECT *
FROM Student
WHERE department IN ('CSE', 'ECE');


-- Names starting with A

SELECT *
FROM Student
WHERE name LIKE 'A%';


/*
========================================================
                   ORDER BY
========================================================
*/

-- Ascending marks

SELECT *
FROM Student
ORDER BY marks ASC;


-- Descending marks

SELECT *
FROM Student
ORDER BY marks DESC;


-- Sort by department and then marks

SELECT *
FROM Student
ORDER BY department ASC, marks DESC;


/*
========================================================
                   DISTINCT
========================================================
*/

-- Display unique departments

SELECT DISTINCT department
FROM Student;


-- Display unique ages

SELECT DISTINCT age
FROM Student;


/*
========================================================
                    LIMIT
========================================================
*/

-- First 3 students

SELECT *
FROM Student
LIMIT 3;


-- Top 3 students by marks

SELECT *
FROM Student
ORDER BY marks DESC
LIMIT 3;


-- Top 5 students

SELECT *
FROM Student
ORDER BY marks DESC
LIMIT 5;


/*
========================================================
                UPDATE
========================================================
*/

-- Change marks of student with id 3

UPDATE Student
SET marks = 85
WHERE id = 3;


-- Change department of student with id 6

UPDATE Student
SET department = 'CSE'
WHERE id = 6;


-- Update multiple columns

UPDATE Student
SET age = 21,
    marks = 90
WHERE id = 4;


-- Increase marks of all CSE students by 5

UPDATE Student
SET marks = marks + 5
WHERE department = 'CSE';


/*
========================================================
                    DELETE
========================================================
*/

-- Delete student with id 8

DELETE FROM Student
WHERE id = 8;


-- Delete students having marks below 75

DELETE FROM Student
WHERE marks < 75;


/*
========================================================
             COMBINED IMPORTANT QUERIES
========================================================
*/

-- Q1. Display CSE students in descending order of marks

SELECT *
FROM Student
WHERE department = 'CSE'
ORDER BY marks DESC;


-- Q2. Display top 3 CSE students

SELECT *
FROM Student
WHERE department = 'CSE'
ORDER BY marks DESC
LIMIT 3;


-- Q3. Display unique departments

SELECT DISTINCT department
FROM Student;


-- Q4. Display students aged 20 or above

SELECT *
FROM Student
WHERE age >= 20;


-- Q5. Display students with marks between 80 and 95

SELECT *
FROM Student
WHERE marks BETWEEN 80 AND 95;


-- Q6. Display names starting with A

SELECT name
FROM Student
WHERE name LIKE 'A%';


-- Q7. Display top 2 students

SELECT name, marks
FROM Student
ORDER BY marks DESC
LIMIT 2;


-- Q8. Display second and third highest students

SELECT name, marks
FROM Student
ORDER BY marks DESC
LIMIT 2 OFFSET 1;


/*
========================================================
             IMPORTANT EXAM QUESTIONS
========================================================

Q1. What is DML?

Q2. Explain INSERT with syntax and example.

Q3. Explain UPDATE with syntax and example.

Q4. Explain DELETE with syntax and example.

Q5. What is SELECT?

Q6. What is the use of WHERE?

Q7. Difference between WHERE and ORDER BY.

Q8. What is DISTINCT?

Q9. What is LIMIT?

Q10. Difference between DELETE and TRUNCATE.

Q11. Write a query to find students with marks > 80.

Q12. Write a query to display unique departments.

Q13. Write a query to display students in descending
    order of marks.

Q14. Write a query to display the top 3 students.

Q15. Write a query to update marks of a particular student.

Q16. Write a query to delete a particular student.

========================================================
                MOST IMPORTANT FOR EXAM
========================================================

Remember these 8:

INSERT INTO Student VALUES (...);
        ↓
ADD DATA

UPDATE Student
SET marks = 90
WHERE id = 1;
        ↓
CHANGE DATA

DELETE FROM Student
WHERE id = 1;
        ↓
REMOVE DATA

SELECT *
FROM Student;
        ↓
DISPLAY DATA

SELECT *
FROM Student
WHERE marks > 80;
        ↓
FILTER

SELECT *
FROM Student
ORDER BY marks DESC;
        ↓
SORT

SELECT DISTINCT department
FROM Student;
        ↓
UNIQUE VALUES

SELECT *
FROM Student
ORDER BY marks DESC
LIMIT 3;
        ↓
TOP 3

========================================================
*/