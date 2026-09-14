/*
========================================================
        NESTED QUERIES, SUBQUERIES, SET OPERATIONS
                    AND DCL
========================================================

TOPICS:

1. Nested Queries / Subqueries
2. Single-row Subquery
3. Multi-row Subquery
4. Correlated Subquery
5. Subquery with IN
6. Subquery with EXISTS
7. Subquery with ANY / ALL
8. UNION
9. INTERSECT
10. MINUS
11. DCL
12. GRANT
13. REVOKE

========================================================
1. SUBQUERY / NESTED QUERY
========================================================

A subquery is a query written inside another SQL query.

The inner query is called the SUBQUERY.

The outer query is called the MAIN QUERY.

General syntax:

SELECT ...
FROM ...
WHERE column operator
    (SELECT ...);

Example:

SELECT name
FROM Student
WHERE marks >
    (SELECT AVG(marks) FROM Student);

The inner query finds the average marks.

The outer query finds students whose marks are
greater than that average.


========================================================
2. NESTED QUERY
========================================================

Nested query and subquery generally refer to the same idea:

A query inside another query.

Example:

SELECT *
FROM Student
WHERE department_id =
    (SELECT department_id
     FROM Department
     WHERE department_name = 'CSE');


========================================================
3. SINGLE-ROW SUBQUERY
========================================================

A single-row subquery returns exactly ONE value/row.

It can be used with operators such as:

=
>
<
>=
<=
<>

Example:

SELECT name, marks
FROM Student
WHERE marks >
    (SELECT AVG(marks)
     FROM Student);

AVG() returns one value.


========================================================
4. MULTI-ROW SUBQUERY
========================================================

A multi-row subquery returns multiple values.

Common operators:

IN
ANY
ALL

Example:

SELECT name
FROM Student
WHERE department_id IN
    (SELECT department_id
     FROM Department
     WHERE department_name IN ('CSE', 'ECE'));


========================================================
5. SUBQUERY WITH IN
========================================================

IN checks whether a value exists in the result
returned by the subquery.

Example:

SELECT name
FROM Student
WHERE department_id IN
    (SELECT department_id
     FROM Department
     WHERE department_name = 'CSE');


========================================================
6. SUBQUERY WITH EXISTS
========================================================

EXISTS checks whether the subquery returns
at least one row.

It returns TRUE if a matching row exists.

Example:

SELECT department_name
FROM Department d
WHERE EXISTS
    (SELECT 1
     FROM Student s
     WHERE s.department_id = d.department_id);


========================================================
7. CORRELATED SUBQUERY
========================================================

A correlated subquery depends on the outer query.

The inner query refers to a column from the outer query.

Example:

SELECT s1.name, s1.marks
FROM Student s1
WHERE s1.marks >
    (SELECT AVG(s2.marks)
     FROM Student s2
     WHERE s2.department_id = s1.department_id);

Meaning:

For every student, calculate the average marks
of that student's department.

Then compare the student's marks with that
department average.


========================================================
8. ANY
========================================================

ANY compares a value with ANY value returned
by the subquery.

Example:

SELECT name, marks
FROM Student
WHERE marks > ANY
    (SELECT marks
     FROM Student
     WHERE department_id = 2);

Meaning:

Marks should be greater than at least ONE value
returned by the subquery.


========================================================
9. ALL
========================================================

ALL compares a value with ALL values returned
by the subquery.

Example:

SELECT name, marks
FROM Student
WHERE marks > ALL
    (SELECT marks
     FROM Student
     WHERE department_id = 2);

Meaning:

Marks should be greater than EVERY value returned
by the subquery.


========================================================
10. SET OPERATIONS
========================================================

Set operations combine the results of two SELECT
queries.

Main set operations:

UNION
INTERSECT
MINUS

Important:

The SELECT queries used with set operations should
have the same number of columns and compatible
data types.


========================================================
11. UNION
========================================================

UNION combines the results of two queries and
removes duplicate rows.

Syntax:

SELECT column FROM table1
UNION
SELECT column FROM table2;

Example:

SELECT name FROM CSE_Students
UNION
SELECT name FROM ECE_Students;


========================================================
12. UNION ALL
========================================================

UNION ALL combines results but DOES NOT remove
duplicates.

Example:

SELECT name FROM CSE_Students
UNION ALL
SELECT name FROM ECE_Students;


Difference:

UNION
= Combines + removes duplicates

UNION ALL
= Combines + keeps duplicates


========================================================
13. INTERSECT
========================================================

INTERSECT returns only rows common to both queries.

Concept:

A ∩ B

= Common elements of A and B.

Standard SQL:

SELECT column FROM TableA
INTERSECT
SELECT column FROM TableB;


MYSQL NOTE:

Modern MySQL versions support INTERSECT.

For compatibility with older MySQL versions,
the same result can be obtained using INNER JOIN
or EXISTS.


========================================================
14. MINUS
========================================================

MINUS returns rows present in the FIRST query
but NOT present in the SECOND query.

Concept:

A - B

= Elements in A but not B.

Standard SQL:

SELECT column FROM TableA
MINUS
SELECT column FROM TableB;


IMPORTANT:

MySQL does NOT use MINUS.

In MySQL, use:

EXCEPT

or an equivalent NOT EXISTS / LEFT JOIN query,
depending on the MySQL version.


========================================================
15. DCL
========================================================

DCL = Data Control Language

DCL is used to control access and permissions
on database objects.

Main DCL commands:

GRANT
REVOKE


========================================================
16. GRANT
========================================================

GRANT gives privileges/permissions to a user.

Syntax:

GRANT privilege
ON database.table
TO 'username'@'host';

Common privileges:

SELECT
INSERT
UPDATE
DELETE
ALL PRIVILEGES


Example:

GRANT SELECT
ON CollegeDB.Student
TO 'user1'@'localhost';


Multiple privileges:

GRANT SELECT, INSERT, UPDATE
ON CollegeDB.Student
TO 'user1'@'localhost';


All privileges:

GRANT ALL PRIVILEGES
ON CollegeDB.*
TO 'user1'@'localhost';


========================================================
17. REVOKE
========================================================

REVOKE removes previously granted privileges.

Syntax:

REVOKE privilege
ON database.table
FROM 'username'@'host';

Example:

REVOKE INSERT
ON CollegeDB.Student
FROM 'user1'@'localhost';


Remove multiple privileges:

REVOKE SELECT, UPDATE
ON CollegeDB.Student
FROM 'user1'@'localhost';


========================================================
18. GRANT vs REVOKE
========================================================

GRANT
= Gives permission

REVOKE
= Removes permission


Example:

GRANT SELECT
-> User can read data.

REVOKE SELECT
-> User can no longer read data.


========================================================
                  RUNNABLE SQL
========================================================
*/

CREATE DATABASE SubqueryDB;

USE SubqueryDB;


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
*/

INSERT INTO Student
VALUES
(101, 'Rahul', 1, 85),
(102, 'Priya', 2, 92),
(103, 'Aman', 1, 78),
(104, 'Neha', 3, 88),
(105, 'Riya', 1, 95),
(106, 'Karan', 2, 72),
(107, 'Anjali', 3, 90),
(108, 'Arjun', 1, 95),
(109, 'Simran', 2, 86);


/*
========================================================
              BASIC SUBQUERY
========================================================
*/

-- Find students who scored above the average marks

SELECT name, marks
FROM Student
WHERE marks >
    (SELECT AVG(marks)
     FROM Student);


/*
========================================================
            SUBQUERY WITH MAX()
========================================================
*/

-- Find student(s) having the highest marks

SELECT name, marks
FROM Student
WHERE marks =
    (SELECT MAX(marks)
     FROM Student);


/*
========================================================
            SUBQUERY WITH MIN()
========================================================
*/

-- Find student(s) having the lowest marks

SELECT name, marks
FROM Student
WHERE marks =
    (SELECT MIN(marks)
     FROM Student);


/*
========================================================
              SUBQUERY WITH IN
========================================================
*/

-- Find students belonging to CSE

SELECT name
FROM Student
WHERE department_id IN
    (SELECT department_id
     FROM Department
     WHERE department_name = 'CSE');


/*
========================================================
             SUBQUERY WITH NOT IN
========================================================
*/

-- Find students who are NOT from CSE

SELECT name
FROM Student
WHERE department_id NOT IN
    (SELECT department_id
     FROM Department
     WHERE department_name = 'CSE');


/*
========================================================
                EXISTS
========================================================
*/

-- Find departments that have at least one student

SELECT department_name
FROM Department d
WHERE EXISTS
    (SELECT 1
     FROM Student s
     WHERE s.department_id = d.department_id);


/*
========================================================
              NOT EXISTS
========================================================
*/

-- Find departments having no students

SELECT department_name
FROM Department d
WHERE NOT EXISTS
    (SELECT 1
     FROM Student s
     WHERE s.department_id = d.department_id);


/*
========================================================
             CORRELATED SUBQUERY
========================================================

Find students whose marks are greater than the
average marks of their own department.
*/

SELECT s1.name, s1.department_id, s1.marks
FROM Student s1
WHERE s1.marks >
    (SELECT AVG(s2.marks)
     FROM Student s2
     WHERE s2.department_id = s1.department_id);


/*
========================================================
                    ANY
========================================================

Find students whose marks are greater than at least
one student from ECE.
*/

SELECT name, marks
FROM Student
WHERE marks > ANY
    (SELECT marks
     FROM Student
     WHERE department_id = 2);


/*
========================================================
                    ALL
========================================================

Find students whose marks are greater than every
student from ECE.
*/

SELECT name, marks
FROM Student
WHERE marks > ALL
    (SELECT marks
     FROM Student
     WHERE department_id = 2);


/*
========================================================
                    UNION
========================================================
*/

-- Students from CSE and ECE

SELECT name
FROM Student
WHERE department_id = 1

UNION

SELECT name
FROM Student
WHERE department_id = 2;


/*
========================================================
                  UNION ALL
========================================================
*/

SELECT name
FROM Student
WHERE department_id = 1

UNION ALL

SELECT name
FROM Student
WHERE department_id = 2;


/*
========================================================
                  INTERSECT
========================================================

Find marks that appear in both CSE and ECE.

For MySQL versions supporting INTERSECT:
*/

SELECT marks
FROM Student
WHERE department_id = 1

INTERSECT

SELECT marks
FROM Student
WHERE department_id = 2;


/*
========================================================
       INTERSECT ALTERNATIVE USING EXISTS
========================================================

This approach is useful when INTERSECT is unavailable.
*/

SELECT DISTINCT s1.marks
FROM Student s1
WHERE department_id = 1
AND EXISTS
    (SELECT 1
     FROM Student s2
     WHERE s2.department_id = 2
     AND s2.marks = s1.marks);


/*
========================================================
                    MINUS
========================================================

Standard SQL:

SELECT ...
MINUS
SELECT ...

MySQL uses EXCEPT instead of MINUS in versions
that support EXCEPT.

Example:

CSE marks that are NOT present in ECE.
*/

SELECT marks
FROM Student
WHERE department_id = 1

EXCEPT

SELECT marks
FROM Student
WHERE department_id = 2;


/*
========================================================
          MINUS ALTERNATIVE USING NOT EXISTS
========================================================

This is a portable way to represent:

CSE - ECE
*/

SELECT DISTINCT s1.marks
FROM Student s1
WHERE s1.department_id = 1
AND NOT EXISTS
    (SELECT 1
     FROM Student s2
     WHERE s2.department_id = 2
     AND s2.marks = s1.marks);


/*
========================================================
                    DCL
========================================================

The following commands require appropriate MySQL
privileges.

Create a user first if required.
*/

CREATE USER 'student_user'@'localhost'
IDENTIFIED BY 'Student@123';


/*
========================================================
                    GRANT
========================================================
*/

-- Give SELECT permission

GRANT SELECT
ON SubqueryDB.Student
TO 'student_user'@'localhost';


-- Give SELECT and INSERT permissions

GRANT SELECT, INSERT
ON SubqueryDB.Student
TO 'student_user'@'localhost';


-- Give SELECT, INSERT and UPDATE permissions

GRANT SELECT, INSERT, UPDATE
ON SubqueryDB.Student
TO 'student_user'@'localhost';


/*
========================================================
                  SHOW GRANTS
========================================================
*/

SHOW GRANTS
FOR 'student_user'@'localhost';


/*
========================================================
                    REVOKE
========================================================
*/

-- Remove INSERT permission

REVOKE INSERT
ON SubqueryDB.Student
FROM 'student_user'@'localhost';


-- Remove UPDATE permission

REVOKE UPDATE
ON SubqueryDB.Student
FROM 'student_user'@'localhost';


/*
========================================================
                  IMPORTANT QUESTIONS
========================================================

Q1. What is a subquery?

Q2. What is the difference between a subquery and
    a nested query?

Q3. Explain single-row subquery with an example.

Q4. Explain multi-row subquery.

Q5. Explain IN with a subquery.

Q6. What is EXISTS?

Q7. What is a correlated subquery?

Q8. Difference between ANY and ALL.

Q9. What are set operations?

Q10. Explain UNION and UNION ALL.

Q11. Explain INTERSECT.

Q12. Explain MINUS.

Q13. Does MySQL support MINUS?

Q14. How can MINUS be implemented in MySQL?

Q15. What is DCL?

Q16. Explain GRANT and REVOKE.

Q17. Write a query to find students whose marks
     are greater than the average marks.

Q18. Write a query to find the student with the
     highest marks.

Q19. Write a query to find departments having
     at least one student using EXISTS.

Q20. Write a query to find departments having
     no students using NOT EXISTS.


========================================================
                  EXAM MEMORY TRICK
========================================================

SUBQUERY
= QUERY INSIDE QUERY

IN
= MATCH ANY VALUE IN RESULT

EXISTS
= DOES A ROW EXIST?

ANY
= AT LEAST ONE

ALL
= EVERY VALUE


SET OPERATIONS:

UNION
= A OR B
= COMBINE + REMOVE DUPLICATES

UNION ALL
= COMBINE + KEEP DUPLICATES

INTERSECT
= COMMON IN A AND B

MINUS
= A BUT NOT B


DCL:

GRANT
= GIVE PERMISSION

REVOKE
= TAKE PERMISSION


========================================================
             MOST IMPORTANT FOR EXAM
========================================================

1. SUBQUERY:

SELECT name
FROM Student
WHERE marks >
    (SELECT AVG(marks)
     FROM Student);


2. EXISTS:

SELECT department_name
FROM Department d
WHERE EXISTS
    (SELECT 1
     FROM Student s
     WHERE s.department_id = d.department_id);


3. UNION:

SELECT name FROM Student WHERE department_id = 1
UNION
SELECT name FROM Student WHERE department_id = 2;


4. INTERSECT:

SELECT marks FROM Student WHERE department_id = 1
INTERSECT
SELECT marks FROM Student WHERE department_id = 2;


5. MINUS / EXCEPT:

SELECT marks FROM Student WHERE department_id = 1
EXCEPT
SELECT marks FROM Student WHERE department_id = 2;


6. GRANT:

GRANT SELECT
ON SubqueryDB.Student
TO 'student_user'@'localhost';


7. REVOKE:

REVOKE SELECT
ON SubqueryDB.Student
FROM 'student_user'@'localhost';


========================================================
*/