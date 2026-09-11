/*
===========================================================
                    INTRODUCTION TO DBMS
===========================================================

DBMS = Database Management System

A DBMS is software used to:
- Create databases
- Store data
- Retrieve data
- Update data
- Delete data
- Manage and organize data
- Provide security and access control

Examples of DBMS:
- MySQL
- Oracle
- PostgreSQL
- Microsoft SQL Server
- SQLite

-----------------------------------------------------------
1. DATABASE
-----------------------------------------------------------

A database is an organized collection of related data.

Example:
A college database may contain:
- Student details
- Faculty details
- Course details
- Marks
- Attendance

-----------------------------------------------------------
2. DBMS
-----------------------------------------------------------

DBMS acts as an interface between the user/application
and the database.

User/Application
       |
       v
      DBMS
       |
       v
    Database

Main functions of DBMS:
1. Data storage
2. Data retrieval
3. Data manipulation
4. Data security
5. Data integrity
6. Backup and recovery
7. Concurrency control

-----------------------------------------------------------
3. ADVANTAGES OF DBMS
-----------------------------------------------------------

- Reduces data redundancy
- Improves data consistency
- Provides data security
- Supports multiple users
- Provides backup and recovery
- Maintains data integrity
- Allows efficient data access

-----------------------------------------------------------
4. DATA REDUNDANCY
-----------------------------------------------------------

Data redundancy means unnecessary duplication of data.

Example:

Student ID | Name   | Course
101        | Rahul  | BCA
101        | Rahul  | BCA

The same information is stored repeatedly.

A properly designed database reduces redundancy.

-----------------------------------------------------------
5. DATA INTEGRITY
-----------------------------------------------------------

Data integrity means maintaining accuracy and consistency
of data in the database.

Examples:
- Student ID should be unique.
- Age should not contain invalid values.
- Marks should be within a valid range.

-----------------------------------------------------------
6. DATA SECURITY
-----------------------------------------------------------

DBMS controls who can access or modify data.

Examples:
- Admin can modify all data.
- Teacher can update marks.
- Student can only view their own information.

-----------------------------------------------------------
7. DATABASE MODELS
-----------------------------------------------------------

Common database models:

1. Hierarchical Model
   - Data is organized like a tree.

2. Network Model
   - Data can have multiple relationships.

3. Relational Model
   - Data is stored in tables.
   - Most commonly used model.

4. Object-Oriented Model
   - Data is represented using objects.

-----------------------------------------------------------
8. RELATIONAL DATABASE
-----------------------------------------------------------

In a relational database, data is stored in tables.

A table consists of:
- Rows
- Columns

Row = Record
Column = Attribute/Field

Example:

Student
------------------------------------------------
ID       Name       Age       Course
------------------------------------------------
101      Rahul      20        BCA
102      Priya      21        BCA
103      Aman       19        BTech
------------------------------------------------

-----------------------------------------------------------
9. SQL
-----------------------------------------------------------

SQL = Structured Query Language

SQL is used to communicate with relational databases.

SQL can be used to:
- Create databases and tables
- Insert data
- Retrieve data
- Update data
- Delete data
- Control access

-----------------------------------------------------------
10. TYPES OF SQL COMMANDS
-----------------------------------------------------------

DDL = Data Definition Language
Used to define database structure.

Commands:
- CREATE
- ALTER
- DROP
- TRUNCATE

DML = Data Manipulation Language
Used to manipulate data.

Commands:
- INSERT
- UPDATE
- DELETE

DQL = Data Query Language
Used to retrieve data.

Command:
- SELECT

DCL = Data Control Language
Used to control access.

Commands:
- GRANT
- REVOKE

TCL = Transaction Control Language
Used to manage transactions.

Commands:
- COMMIT
- ROLLBACK
- SAVEPOINT

-----------------------------------------------------------
11. PRIMARY KEY
-----------------------------------------------------------

A primary key uniquely identifies every record in a table.

Properties:
- Must be unique
- Cannot contain NULL
- A table generally has one primary key
  (which can consist of multiple columns)

-----------------------------------------------------------
12. FOREIGN KEY
-----------------------------------------------------------

A foreign key creates a relationship between two tables.

It refers to the primary key of another table.

-----------------------------------------------------------
13. CONSTRAINTS
-----------------------------------------------------------

Constraints are rules applied to table columns.

Common constraints:
- PRIMARY KEY
- FOREIGN KEY
- NOT NULL
- UNIQUE
- CHECK
- DEFAULT

-----------------------------------------------------------
14. BASIC SQL EXECUTION ORDER
-----------------------------------------------------------

A simple SQL query:

SELECT column
FROM table
WHERE condition;

Conceptually:
FROM -> WHERE -> SELECT

For more complex queries, clauses include:
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY

===========================================================
                    RUNNABLE SQL
===========================================================
*/


-- =========================================================
-- CREATE DATABASE
-- =========================================================

CREATE DATABASE CollegeDB;


-- Select the database
-- MySQL / MariaDB syntax

USE CollegeDB;


-- =========================================================
-- CREATE TABLE
-- =========================================================

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 16),
    course VARCHAR(50) DEFAULT 'BCA'
);


-- =========================================================
-- INSERT DATA
-- =========================================================

INSERT INTO Student (student_id, name, age, course)
VALUES
(101, 'Rahul', 20, 'BCA'),
(102, 'Priya', 21, 'BCA'),
(103, 'Aman', 19, 'BTech'),
(104, 'Neha', 20, 'BCA');


-- =========================================================
-- DISPLAY ALL DATA
-- =========================================================

SELECT * FROM Student;


-- =========================================================
-- DISPLAY SPECIFIC COLUMNS
-- =========================================================

SELECT student_id, name, course
FROM Student;


-- =========================================================
-- WHERE CLAUSE
-- =========================================================

SELECT *
FROM Student
WHERE course = 'BCA';


-- =========================================================
-- UPDATE DATA
-- =========================================================

UPDATE Student
SET age = 22
WHERE student_id = 102;


-- =========================================================
-- DELETE DATA
-- =========================================================

DELETE FROM Student
WHERE student_id = 104;


-- =========================================================
-- ALTER TABLE
-- Add a new column
-- =========================================================

ALTER TABLE Student
ADD email VARCHAR(100);


-- =========================================================
-- UPDATE THE NEW COLUMN
-- =========================================================

UPDATE Student
SET email = 'rahul@gmail.com'
WHERE student_id = 101;


-- =========================================================
-- UNIQUE CONSTRAINT EXAMPLE
-- =========================================================

CREATE TABLE Faculty (
    faculty_id INT PRIMARY KEY,
    faculty_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);


-- =========================================================
-- FOREIGN KEY EXAMPLE
-- =========================================================

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL
);


CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,

    FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);


-- =========================================================
-- INSERT COURSE DATA
-- =========================================================

INSERT INTO Course
VALUES
(1, 'BCA'),
(2, 'BTech'),
(3, 'MCA');


-- =========================================================
-- INSERT ENROLLMENT DATA
-- =========================================================

INSERT INTO Enrollment
VALUES
(1, 101, 1),
(2, 102, 1),
(3, 103, 2);


-- =========================================================
-- VIEW ENROLLMENT DATA
-- =========================================================

SELECT * FROM Enrollment;


-- =========================================================
-- BASIC JOIN
-- =========================================================

SELECT
    Student.student_id,
    Student.name,
    Course.course_name
FROM Student
JOIN Enrollment
    ON Student.student_id = Enrollment.student_id
JOIN Course
    ON Enrollment.course_id = Course.course_id;


-- =========================================================
-- DROP EXAMPLE
-- =========================================================

-- DROP TABLE Enrollment;
-- DROP TABLE Course;
-- DROP TABLE Faculty;
-- DROP TABLE Student;

-- DROP DATABASE CollegeDB;


/*
===========================================================
                    QUICK REVISION
===========================================================

DBMS
-> Software used to manage databases.

DATABASE
-> Organized collection of related data.

TABLE
-> Collection of rows and columns.

ROW
-> Represents a record.

COLUMN
-> Represents an attribute/field.

PRIMARY KEY
-> Uniquely identifies each record.

FOREIGN KEY
-> Creates a relationship between tables.

SQL
-> Language used to interact with relational databases.

DDL
-> CREATE, ALTER, DROP, TRUNCATE

DML
-> INSERT, UPDATE, DELETE

DQL
-> SELECT

DCL
-> GRANT, REVOKE

TCL
-> COMMIT, ROLLBACK, SAVEPOINT

IMPORTANT CONSTRAINTS
-> PRIMARY KEY
-> FOREIGN KEY
-> NOT NULL
-> UNIQUE
-> CHECK
-> DEFAULT

===========================================================
                    BASIC QUESTIONS
===========================================================

Q1. Create a Student table with:
    id, name, age and marks.
    Make id the primary key.

Q2. Insert 5 student records.

Q3. Display all students.

Q4. Display students having marks greater than 75.

Q5. Update the marks of a particular student.

Q6. Delete a student using student_id.

Q7. Add an email column using ALTER TABLE.

Q8. Create a Course table and connect it with Student
    using a foreign key.

Q9. Explain the difference between:
    DDL, DML, DQL, DCL and TCL.

Q10. What is the difference between a primary key
     and a foreign key?

===========================================================
*/