/*
========================================================
                    DBMS NOTES
========================================================

TOPIC:
SQL JOINS

SUBTOPICS:
1. INNER JOIN
2. LEFT JOIN
3. RIGHT JOIN
4. FULL OUTER JOIN

========================================================
1. WHAT IS A JOIN?
========================================================

A JOIN is used to combine rows from two or more tables
based on a related column.

Example:

Student table
Course table

Both tables may have a common column such as course_id.

JOIN allows us to retrieve related information from
both tables.


========================================================
2. INNER JOIN
========================================================

INNER JOIN returns ONLY the rows that have matching
values in BOTH tables.

Syntax:

SELECT columns
FROM table1
INNER JOIN table2
ON table1.column = table2.column;

Example:

SELECT Student.name, Course.course_name
FROM Student
INNER JOIN Course
ON Student.course_id = Course.course_id;

Meaning:

Only students whose course_id exists in Course
will be displayed.


========================================================
3. LEFT JOIN
========================================================

LEFT JOIN returns:

- ALL rows from the LEFT table
- Matching rows from the RIGHT table

If there is no match in the right table,
NULL is returned for the right table's columns.

Syntax:

SELECT columns
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;

Remember:

LEFT JOIN = EVERYTHING FROM LEFT TABLE


========================================================
4. RIGHT JOIN
========================================================

RIGHT JOIN returns:

- ALL rows from the RIGHT table
- Matching rows from the LEFT table

If there is no match in the left table,
NULL is returned for the left table's columns.

Syntax:

SELECT columns
FROM table1
RIGHT JOIN table2
ON table1.column = table2.column;

Remember:

RIGHT JOIN = EVERYTHING FROM RIGHT TABLE


========================================================
5. FULL OUTER JOIN
========================================================

FULL OUTER JOIN returns:

- ALL matching rows
- All unmatched rows from the LEFT table
- All unmatched rows from the RIGHT table

If there is no match, NULL values appear
for the missing side.

Concept:

LEFT JOIN + RIGHT JOIN

Standard SQL syntax:

SELECT *
FROM Student
FULL OUTER JOIN Course
ON Student.course_id = Course.course_id;


IMPORTANT FOR MYSQL:

MySQL does NOT directly support FULL OUTER JOIN.

It can be simulated using:

LEFT JOIN
UNION
RIGHT JOIN


========================================================
6. JOIN COMPARISON
========================================================

INNER JOIN:
Only matching rows.

LEFT JOIN:
All left rows + matching right rows.

RIGHT JOIN:
All right rows + matching left rows.

FULL OUTER JOIN:
All rows from both tables.


========================================================
7. VISUAL MEMORY
========================================================

Suppose:

TABLE A       TABLE B

   A          B
   \          /
    \        /
     MATCH


INNER JOIN
= MATCH ONLY


LEFT JOIN
= ALL A + MATCHING B


RIGHT JOIN
= MATCHING A + ALL B


FULL OUTER JOIN
= ALL A + ALL B


========================================================
8. JOIN USING PRIMARY KEY / FOREIGN KEY
========================================================

Most joins are performed using:

Primary Key
+
Foreign Key

Example:

Department:
department_id -> PRIMARY KEY

Student:
department_id -> FOREIGN KEY

Then:

Student.department_id
=
Department.department_id


========================================================
9. ALIASES WITH JOINS
========================================================

Aliases make queries shorter and easier to read.

Example:

SELECT s.name, d.department_name
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id;

s = Student
d = Department


========================================================
10. JOIN WITH WHERE
========================================================

JOIN can be combined with WHERE.

Example:

SELECT s.name, d.department_name
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id
WHERE s.marks > 80;


========================================================
11. JOIN WITH ORDER BY
========================================================

Example:

SELECT s.name, s.marks, d.department_name
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id
ORDER BY s.marks DESC;


========================================================
12. JOIN WITH GROUP BY
========================================================

Example:

SELECT d.department_name, COUNT(s.id)
FROM Department d
LEFT JOIN Student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;

LEFT JOIN is useful here because departments with
ZERO students can also be displayed.


========================================================
                  RUNNABLE SQL
========================================================
*/

CREATE DATABASE JoinDB;

USE JoinDB;


/*
========================================================
                CREATE DEPARTMENT
========================================================
*/

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);


/*
========================================================
                  CREATE STUDENT
========================================================
*/

CREATE TABLE Student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department_id INT,
    marks INT,
    FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
);


/*
========================================================
                INSERT DEPARTMENTS
========================================================
*/

INSERT INTO Department
VALUES
(1, 'CSE'),
(2, 'ECE'),
(3, 'ME'),
(4, 'CIVIL');


/*
========================================================
                  INSERT STUDENTS
========================================================

Notice:

Department 4 (CIVIL) has no student.

This will help demonstrate LEFT JOIN.

All students below have a valid department,
so RIGHT JOIN can be demonstrated as well.
*/

INSERT INTO Student
VALUES
(101, 'Rahul', 20, 1, 85),
(102, 'Priya', 21, 2, 92),
(103, 'Aman', 19, 1, 78),
(104, 'Neha', 22, 3, 88);


/*
========================================================
                  INNER JOIN
========================================================

Only matching departments and students are displayed.
*/

SELECT
    Student.id,
    Student.name,
    Department.department_name
FROM Student
INNER JOIN Department
ON Student.department_id = Department.department_id;


/*
========================================================
                   LEFT JOIN
========================================================

All students are displayed.

If a student's department does not exist,
department_name would be NULL.
*/

SELECT
    Student.id,
    Student.name,
    Department.department_name
FROM Student
LEFT JOIN Department
ON Student.department_id = Department.department_id;


/*
========================================================
                  RIGHT JOIN
========================================================

All departments are displayed.

CIVIL has no student, so student columns
will contain NULL for CIVIL.
*/

SELECT
    Student.id,
    Student.name,
    Department.department_name
FROM Student
RIGHT JOIN Department
ON Student.department_id = Department.department_id;


/*
========================================================
              FULL OUTER JOIN - MYSQL
========================================================

MySQL does not directly support:

FULL OUTER JOIN

So we simulate it using:

LEFT JOIN
UNION
RIGHT JOIN
*/

SELECT
    Student.id,
    Student.name,
    Department.department_name
FROM Student
LEFT JOIN Department
ON Student.department_id = Department.department_id

UNION

SELECT
    Student.id,
    Student.name,
    Department.department_name
FROM Student
RIGHT JOIN Department
ON Student.department_id = Department.department_id;


/*
========================================================
                  USING ALIASES
========================================================
*/

SELECT
    s.name,
    d.department_name,
    s.marks
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id;


/*
========================================================
                JOIN + WHERE
========================================================

Display students having marks greater than 80.
*/

SELECT
    s.name,
    d.department_name,
    s.marks
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id
WHERE s.marks > 80;


/*
========================================================
               JOIN + ORDER BY
========================================================

Display students from highest to lowest marks.
*/

SELECT
    s.name,
    d.department_name,
    s.marks
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id
ORDER BY s.marks DESC;


/*
========================================================
            LEFT JOIN + GROUP BY
========================================================

Count students in every department.

CIVIL will also appear with count 0.
*/

SELECT
    d.department_name,
    COUNT(s.id) AS total_students
FROM Department d
LEFT JOIN Student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;


/*
========================================================
               JOIN + AGGREGATE
========================================================

Find average marks of each department.
*/

SELECT
    d.department_name,
    AVG(s.marks) AS average_marks
FROM Department d
INNER JOIN Student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;


/*
========================================================
                 JOIN + HAVING
========================================================

Display departments whose average marks are
greater than 80.
*/

SELECT
    d.department_name,
    AVG(s.marks) AS average_marks
FROM Department d
INNER JOIN Student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name
HAVING AVG(s.marks) > 80;


/*
========================================================
            FIND DEPARTMENTS WITH NO STUDENTS
========================================================

LEFT JOIN + IS NULL
*/

SELECT
    d.department_name
FROM Department d
LEFT JOIN Student s
ON d.department_id = s.department_id
WHERE s.id IS NULL;


/*
========================================================
              IMPORTANT QUESTIONS
========================================================

Q1. What is a JOIN in SQL?

Q2. Explain INNER JOIN with syntax and example.

Q3. Explain LEFT JOIN with syntax and example.

Q4. Explain RIGHT JOIN with syntax and example.

Q5. What is FULL OUTER JOIN?

Q6. Does MySQL support FULL OUTER JOIN directly?

Q7. How can FULL OUTER JOIN be implemented in MySQL?

Q8. Difference between INNER JOIN and LEFT JOIN.

Q9. Difference between LEFT JOIN and RIGHT JOIN.

Q10. Write a query to display student names along
     with their department names.

Q11. Write a query to display ALL departments,
     including departments having no students.

Q12. Write a query to count students in each department.

Q13. Write a query to find the average marks
     of each department.

Q14. Write a query to find departments having
     average marks greater than 80.

========================================================
                 EXAM MEMORY TRICK
========================================================

INNER JOIN
= MATCHING ONLY

LEFT JOIN
= ALL LEFT + MATCHING RIGHT

RIGHT JOIN
= ALL RIGHT + MATCHING LEFT

FULL OUTER JOIN
= EVERYTHING FROM BOTH


========================================================
                  MOST IMPORTANT
========================================================

                 TABLE A       TABLE B

INNER JOIN         MATCH ONLY

LEFT JOIN          ALL A + MATCH B

RIGHT JOIN         MATCH A + ALL B

FULL JOIN          ALL A + ALL B


MYSQL:

FULL OUTER JOIN ❌

Use:

LEFT JOIN
UNION
RIGHT JOIN


========================================================
*/