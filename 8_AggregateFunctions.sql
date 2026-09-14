/*
========================================================
        AGGREGATE FUNCTIONS, GROUP BY & HAVING
========================================================

TOPICS:
1. Aggregate Functions
2. COUNT()
3. SUM()
4. AVG()
5. MIN()
6. MAX()
7. GROUP BY
8. HAVING Clause

========================================================
1. AGGREGATE FUNCTIONS
========================================================

Aggregate functions perform calculations on multiple rows
and return a single result.

Main aggregate functions:

COUNT() -> Counts values/rows
SUM()   -> Adds numeric values
AVG()   -> Finds average
MIN()   -> Finds minimum value
MAX()   -> Finds maximum value


========================================================
2. COUNT()
========================================================

COUNT() is used to count rows or non-NULL values.

Syntax:

SELECT COUNT(*)
FROM table_name;

Example:

SELECT COUNT(*)
FROM Student;

This returns the total number of rows.

COUNT(column_name) counts non-NULL values in that column.

Example:

SELECT COUNT(marks)
FROM Student;


COUNT(DISTINCT column_name) counts unique non-NULL values.

Example:

SELECT COUNT(DISTINCT department)
FROM Student;


========================================================
3. SUM()
========================================================

SUM() calculates the total of numeric values.

Syntax:

SELECT SUM(column_name)
FROM table_name;

Example:

SELECT SUM(marks)
FROM Student;

It returns the total marks of all students.


========================================================
4. AVG()
========================================================

AVG() calculates the average of numeric values.

Syntax:

SELECT AVG(column_name)
FROM table_name;

Example:

SELECT AVG(marks)
FROM Student;


========================================================
5. MIN()
========================================================

MIN() returns the smallest value.

Syntax:

SELECT MIN(column_name)
FROM table_name;

Example:

SELECT MIN(marks)
FROM Student;

It returns the lowest marks.


========================================================
6. MAX()
========================================================

MAX() returns the largest value.

Syntax:

SELECT MAX(column_name)
FROM table_name;

Example:

SELECT MAX(marks)
FROM Student;

It returns the highest marks.


========================================================
7. GROUP BY
========================================================

GROUP BY is used to group rows having the same value.

It is commonly used with aggregate functions.

Syntax:

SELECT column_name, aggregate_function(column_name)
FROM table_name
GROUP BY column_name;

Example:

SELECT department, COUNT(*)
FROM Student
GROUP BY department;

This creates groups based on department and counts the
students in each department.


========================================================
8. GROUP BY WITH DIFFERENT FUNCTIONS
========================================================

COUNT():

SELECT department, COUNT(*)
FROM Student
GROUP BY department;


SUM():

SELECT department, SUM(marks)
FROM Student
GROUP BY department;


AVG():

SELECT department, AVG(marks)
FROM Student
GROUP BY department;


MIN():

SELECT department, MIN(marks)
FROM Student
GROUP BY department;


MAX():

SELECT department, MAX(marks)
FROM Student
GROUP BY department;


========================================================
9. HAVING CLAUSE
========================================================

HAVING is used to filter GROUPS.

WHERE filters individual rows.

HAVING filters groups after GROUP BY.

Syntax:

SELECT column, aggregate_function(column)
FROM table_name
GROUP BY column
HAVING condition;


Example:

SELECT department, AVG(marks)
FROM Student
GROUP BY department
HAVING AVG(marks) > 80;

This displays only departments whose average marks are
greater than 80.


========================================================
10. WHERE vs HAVING
========================================================

WHERE:
- Filters individual rows.
- Used before GROUP BY.
- Usually used with normal conditions.

Example:

SELECT *
FROM Student
WHERE marks > 80;


HAVING:
- Filters groups.
- Used after GROUP BY.
- Commonly used with aggregate functions.

Example:

SELECT department, AVG(marks)
FROM Student
GROUP BY department
HAVING AVG(marks) > 80;


========================================================
11. WHERE + GROUP BY + HAVING
========================================================

All three can be used together.

Example:

SELECT department, AVG(marks)
FROM Student
WHERE age >= 20
GROUP BY department
HAVING AVG(marks) > 80;

Meaning:

1. WHERE filters students whose age is at least 20.
2. GROUP BY groups remaining students by department.
3. AVG calculates average marks for each department.
4. HAVING keeps only groups with average marks > 80.


========================================================
12. SQL CLAUSE ORDER
========================================================

Writing order:

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT

Example:

SELECT department, AVG(marks)
FROM Student
WHERE age >= 20
GROUP BY department
HAVING AVG(marks) >= 80
ORDER BY AVG(marks) DESC
LIMIT 3;


========================================================
13. IMPORTANT DIFFERENCE
========================================================

WHERE = Filters ROWS

HAVING = Filters GROUPS

GROUP BY = Creates GROUPS

Aggregate Functions = Perform calculations on groups
or sets of rows.


========================================================
                 RUNNABLE SQL
========================================================
*/

CREATE DATABASE AggregateDB;

USE AggregateDB;


-- ======================================================
-- CREATE STUDENT TABLE
-- ======================================================

CREATE TABLE Student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department VARCHAR(30),
    marks INT
);


-- ======================================================
-- INSERT SAMPLE DATA
-- ======================================================

INSERT INTO Student
VALUES
(1, 'Rahul', 20, 'CSE', 85),
(2, 'Priya', 21, 'ECE', 92),
(3, 'Aman', 19, 'CSE', 78),
(4, 'Neha', 22, 'ME', 88),
(5, 'Riya', 20, 'CSE', 95),
(6, 'Karan', 21, 'ECE', 72),
(7, 'Anjali', 19, 'ME', 90),
(8, 'Arjun', 23, 'CSE', 95),
(9, 'Simran', 20, 'ECE', 86),
(10, 'Dev', 22, 'ME', 75);


/*
========================================================
                    COUNT()
========================================================
*/

-- Count total students

SELECT COUNT(*) AS total_students
FROM Student;


-- Count students having marks

SELECT COUNT(marks) AS students_with_marks
FROM Student;


-- Count unique departments

SELECT COUNT(DISTINCT department) AS total_departments
FROM Student;


/*
========================================================
                    SUM()
========================================================
*/

-- Total marks of all students

SELECT SUM(marks) AS total_marks
FROM Student;


/*
========================================================
                    AVG()
========================================================
*/

-- Average marks of all students

SELECT AVG(marks) AS average_marks
FROM Student;


/*
========================================================
                    MIN()
========================================================
*/

-- Lowest marks

SELECT MIN(marks) AS lowest_marks
FROM Student;


/*
========================================================
                    MAX()
========================================================
*/

-- Highest marks

SELECT MAX(marks) AS highest_marks
FROM Student;


/*
========================================================
                    GROUP BY
========================================================
*/

-- Count students in each department

SELECT
    department,
    COUNT(*) AS total_students
FROM Student
GROUP BY department;


-- Total marks of each department

SELECT
    department,
    SUM(marks) AS total_marks
FROM Student
GROUP BY department;


-- Average marks of each department

SELECT
    department,
    AVG(marks) AS average_marks
FROM Student
GROUP BY department;


-- Minimum marks in each department

SELECT
    department,
    MIN(marks) AS minimum_marks
FROM Student
GROUP BY department;


-- Maximum marks in each department

SELECT
    department,
    MAX(marks) AS maximum_marks
FROM Student
GROUP BY department;


/*
========================================================
                    HAVING
========================================================
*/

-- Departments having more than 2 students

SELECT
    department,
    COUNT(*) AS total_students
FROM Student
GROUP BY department
HAVING COUNT(*) > 2;


-- Departments having average marks greater than 85

SELECT
    department,
    AVG(marks) AS average_marks
FROM Student
GROUP BY department
HAVING AVG(marks) > 85;


-- Departments whose total marks are greater than 250

SELECT
    department,
    SUM(marks) AS total_marks
FROM Student
GROUP BY department
HAVING SUM(marks) > 250;


/*
========================================================
              WHERE + GROUP BY + HAVING
========================================================
*/

-- Consider only students aged 20 or above.
-- Group them by department.
-- Display departments with average marks above 80.

SELECT
    department,
    AVG(marks) AS average_marks
FROM Student
WHERE age >= 20
GROUP BY department
HAVING AVG(marks) > 80;


/*
========================================================
                    ORDER BY
========================================================
*/

-- Display departments by highest average marks first

SELECT
    department,
    AVG(marks) AS average_marks
FROM Student
GROUP BY department
ORDER BY average_marks DESC;


/*
========================================================
          GROUP BY + HAVING + ORDER BY
========================================================
*/

SELECT
    department,
    COUNT(*) AS total_students,
    AVG(marks) AS average_marks
FROM Student
GROUP BY department
HAVING AVG(marks) >= 80
ORDER BY average_marks DESC;


/*
========================================================
            GROUP BY + HAVING + LIMIT
========================================================
*/

-- Display the department with the highest average marks

SELECT
    department,
    AVG(marks) AS average_marks
FROM Student
GROUP BY department
ORDER BY average_marks DESC
LIMIT 1;


/*
========================================================
              IMPORTANT PRACTICE QUERIES
========================================================
*/

-- Q1. Find the total number of students

SELECT COUNT(*) AS total_students
FROM Student;


-- Q2. Find the total marks of all students

SELECT SUM(marks) AS total_marks
FROM Student;


-- Q3. Find the average marks

SELECT AVG(marks) AS average_marks
FROM Student;


-- Q4. Find the highest marks

SELECT MAX(marks) AS highest_marks
FROM Student;


-- Q5. Find the lowest marks

SELECT MIN(marks) AS lowest_marks
FROM Student;


-- Q6. Count students in each department

SELECT
    department,
    COUNT(*) AS total_students
FROM Student
GROUP BY department;


-- Q7. Find average marks of each department

SELECT
    department,
    AVG(marks) AS average_marks
FROM Student
GROUP BY department;


-- Q8. Display departments having more than 3 students

SELECT
    department,
    COUNT(*) AS total_students
FROM Student
GROUP BY department
HAVING COUNT(*) > 3;


-- Q9. Display departments having average marks greater than 85

SELECT
    department,
    AVG(marks) AS average_marks
FROM Student
GROUP BY department
HAVING AVG(marks) > 85;


-- Q10. Find the department with the highest average marks

SELECT
    department,
    AVG(marks) AS average_marks
FROM Student
GROUP BY department
ORDER BY average_marks DESC
LIMIT 1;


/*
========================================================
                    QUICK REVISION
========================================================

COUNT()
-> Counts rows/values.

SUM()
-> Adds numeric values.

AVG()
-> Calculates average.

MIN()
-> Finds smallest value.

MAX()
-> Finds largest value.

GROUP BY
-> Groups rows with the same value.

HAVING
-> Filters groups.

WHERE
-> Filters rows.


========================================================
              WHERE vs HAVING
========================================================

WHERE:

SELECT *
FROM Student
WHERE marks > 80;

Filters individual students/rows.


HAVING:

SELECT department, AVG(marks)
FROM Student
GROUP BY department
HAVING AVG(marks) > 80;

Filters departments/groups.


========================================================
              EXAM MEMORY TRICK
========================================================

COUNT = HOW MANY?
SUM   = TOTAL
AVG   = AVERAGE
MIN   = LOWEST
MAX   = HIGHEST

GROUP BY = MAKE GROUPS
HAVING   = FILTER GROUPS
WHERE    = FILTER ROWS


========================================================
              IMPORTANT EXAM QUESTIONS
========================================================

Q1. What are aggregate functions in SQL?

Q2. Explain COUNT(), SUM(), AVG(), MIN() and MAX()
    with examples.

Q3. What is GROUP BY?

Q4. What is the HAVING clause?

Q5. Differentiate between WHERE and HAVING.

Q6. Write a query to count students in each department.

Q7. Write a query to find the average marks of each
    department.

Q8. Display departments having more than 5 students.

Q9. Display departments whose average marks are
    greater than 80.

Q10. Find the department having the highest average marks.

Q11. Write a query using:
     WHERE + GROUP BY + HAVING.

Q12. What is the correct order of clauses in a SQL query?

========================================================
*/
