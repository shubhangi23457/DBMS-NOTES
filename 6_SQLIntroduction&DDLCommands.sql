/*
===========================================================
              SQL INTRODUCTION AND DDL COMMANDS
===========================================================

1. WHAT IS SQL?
-----------------------------------------------------------

SQL = Structured Query Language

SQL is used to communicate with relational databases.

SQL allows us to:
- Create databases and tables
- Store data
- Retrieve data
- Modify data
- Delete data
- Control access
- Manage transactions


2. FEATURES OF SQL
-----------------------------------------------------------

- Easy to learn and use
- Used with relational databases
- Supports data definition
- Supports data manipulation
- Supports data retrieval
- Provides security
- Supports constraints
- Supports transactions


3. SQL COMMAND CATEGORIES
-----------------------------------------------------------

DDL = Data Definition Language
Used to define and modify database structure.

Commands:
- CREATE
- ALTER
- DROP
- TRUNCATE


DML = Data Manipulation Language
Used to modify data.

Commands:
- INSERT
- UPDATE
- DELETE


DQL = Data Query Language
Used to retrieve data.

Command:
- SELECT


DCL = Data Control Language
Used to control database access.

Commands:
- GRANT
- REVOKE


TCL = Transaction Control Language
Used to manage transactions.

Commands:
- COMMIT
- ROLLBACK
- SAVEPOINT


===========================================================
                    DDL COMMANDS
===========================================================

DDL commands are used to define, create, modify and
remove database objects such as:
- Databases
- Tables
- Views
- Indexes


===========================================================
1. CREATE
===========================================================

CREATE is used to create a new database object.

Syntax:

CREATE DATABASE database_name;

CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    ...
);


-----------------------------------------------------------
CREATE DATABASE
-----------------------------------------------------------

Creates a new database.

Example:

CREATE DATABASE CollegeDB;


-----------------------------------------------------------
CREATE TABLE
-----------------------------------------------------------

Creates a new table.

Example:

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);


===========================================================
2. ALTER
===========================================================

ALTER is used to modify the structure of an existing
database object.

It can be used to:
- Add columns
- Modify columns
- Rename columns
- Drop columns
- Add constraints
- Drop constraints


-----------------------------------------------------------
ADD COLUMN
-----------------------------------------------------------

Syntax:

ALTER TABLE table_name
ADD column_name datatype;


Example:

ALTER TABLE Student
ADD email VARCHAR(100);


-----------------------------------------------------------
MODIFY COLUMN
-----------------------------------------------------------

Changes the datatype or definition of a column.

MySQL syntax:

ALTER TABLE Student
MODIFY age SMALLINT;


-----------------------------------------------------------
RENAME COLUMN
-----------------------------------------------------------

MySQL syntax:

ALTER TABLE Student
RENAME COLUMN name TO student_name;


-----------------------------------------------------------
DROP COLUMN
-----------------------------------------------------------

Removes a column from a table.

Syntax:

ALTER TABLE table_name
DROP COLUMN column_name;


Example:

ALTER TABLE Student
DROP COLUMN email;


-----------------------------------------------------------
ADD CONSTRAINT
-----------------------------------------------------------

Example:

ALTER TABLE Student
ADD CONSTRAINT unique_student_name
UNIQUE(student_name);


===========================================================
3. DROP
===========================================================

DROP permanently removes a database object.

Examples:

DROP DATABASE database_name;

DROP TABLE table_name;

DROP VIEW view_name;


IMPORTANT:
DROP TABLE removes:
- Table structure
- Data
- Associated table definition


Example:

DROP TABLE Student;


DROP DATABASE removes the entire database and its objects.


===========================================================
4. TRUNCATE
===========================================================

TRUNCATE removes ALL rows from a table but keeps the
table structure.

Syntax:

TRUNCATE TABLE table_name;


After TRUNCATE:

Table structure -> Remains
Rows            -> Removed


Example:

TRUNCATE TABLE Student;


===========================================================
DROP vs TRUNCATE vs DELETE
===========================================================

DROP:
-> Removes table structure and data.
-> Table no longer exists.

TRUNCATE:
-> Removes all rows.
-> Table structure remains.
-> Cannot specify a WHERE condition.

DELETE:
-> Removes rows.
-> Table structure remains.
-> Can use WHERE condition.


Example:

DELETE FROM Student
WHERE student_id = 101;


TRUNCATE TABLE Student;


DROP TABLE Student;


===========================================================
CREATE vs ALTER vs DROP vs TRUNCATE
===========================================================

CREATE
-> Creates a new database object.

ALTER
-> Changes the structure of an existing object.

DROP
-> Completely removes the object.

TRUNCATE
-> Removes all rows but preserves table structure.


===========================================================
DDL CHARACTERISTICS
===========================================================

DDL mainly deals with the STRUCTURE of the database.

CREATE
-> Create structure

ALTER
-> Modify structure

DROP
-> Delete structure

TRUNCATE
-> Remove all records while preserving structure


===========================================================
                    RUNNABLE SQL
===========================================================
*/

-- =========================================================
-- CREATE DATABASE
-- =========================================================

CREATE DATABASE SQL_DDL_DB;

USE SQL_DDL_DB;


-- =========================================================
-- CREATE TABLE
-- =========================================================

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT,
    course VARCHAR(50)
);


-- =========================================================
-- INSERT SAMPLE DATA
-- These INSERT statements are DML, included only so that
-- TRUNCATE and ALTER examples can be tested.
-- =========================================================

INSERT INTO Student
VALUES
(101, 'Rahul', 20, 'BCA'),
(102, 'Priya', 21, 'BCA'),
(103, 'Aman', 19, 'BTech'),
(104, 'Neha', 22, 'MCA');


-- =========================================================
-- VIEW TABLE
-- =========================================================

SELECT * FROM Student;


-- =========================================================
-- ALTER: ADD COLUMN
-- =========================================================

ALTER TABLE Student
ADD email VARCHAR(100);


-- =========================================================
-- UPDATE THE NEW COLUMN
-- =========================================================

UPDATE Student
SET email = 'rahul@gmail.com'
WHERE student_id = 101;

UPDATE Student
SET email = 'priya@gmail.com'
WHERE student_id = 102;

UPDATE Student
SET email = 'aman@gmail.com'
WHERE student_id = 103;

UPDATE Student
SET email = 'neha@gmail.com'
WHERE student_id = 104;


-- =========================================================
-- VIEW MODIFIED TABLE
-- =========================================================

SELECT * FROM Student;


-- =========================================================
-- ALTER: MODIFY COLUMN
-- MySQL syntax
-- =========================================================

ALTER TABLE Student
MODIFY age SMALLINT;


-- =========================================================
-- ALTER: RENAME COLUMN
-- =========================================================

ALTER TABLE Student
RENAME COLUMN student_name TO name;


-- =========================================================
-- VIEW TABLE STRUCTURE
-- =========================================================

DESCRIBE Student;


-- =========================================================
-- ALTER: ADD UNIQUE CONSTRAINT
-- =========================================================

ALTER TABLE Student
ADD CONSTRAINT unique_email
UNIQUE(email);


-- =========================================================
-- CREATE ANOTHER TABLE
-- =========================================================

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT
);


-- =========================================================
-- INSERT COURSE DATA
-- =========================================================

INSERT INTO Course
VALUES
(1, 'Database Management System', 4),
(2, 'Java Programming', 4),
(3, 'Computer Networks', 3);


-- =========================================================
-- VIEW COURSE TABLE
-- =========================================================

SELECT * FROM Course;


-- =========================================================
-- TRUNCATE
-- Removes all rows but keeps table structure.
-- =========================================================

TRUNCATE TABLE Course;


-- =========================================================
-- VERIFY TRUNCATE
-- =========================================================

SELECT * FROM Course;


-- The table still exists, but it contains zero rows.


-- =========================================================
-- RE-INSERT DATA AFTER TRUNCATE
-- =========================================================

INSERT INTO Course
VALUES
(1, 'Database Management System', 4),
(2, 'Java Programming', 4),
(3, 'Computer Networks', 3);


-- =========================================================
-- CREATE TEMPORARY TABLE FOR DROP EXAMPLE
-- =========================================================

CREATE TABLE TemporaryData (
    id INT,
    value VARCHAR(50)
);


INSERT INTO TemporaryData
VALUES
(1, 'Test'),
(2, 'Sample');


SELECT * FROM TemporaryData;


-- =========================================================
-- DROP TABLE
-- =========================================================

DROP TABLE TemporaryData;


-- The following query would now produce an error because
-- TemporaryData no longer exists.

-- SELECT * FROM TemporaryData;


-- =========================================================
-- CHECK REMAINING TABLES
-- =========================================================

SHOW TABLES;


/*
===========================================================
                    QUICK REVISION
===========================================================

SQL
-> Structured Query Language.

DDL
-> Data Definition Language.

DDL COMMANDS
-> CREATE
-> ALTER
-> DROP
-> TRUNCATE


CREATE
-> Creates database objects.

ALTER
-> Modifies existing database structure.

DROP
-> Permanently removes database objects.

TRUNCATE
-> Removes all rows but keeps table structure.


===========================================================
                    IMPORTANT DIFFERENCES
===========================================================

DROP:
Data              -> Removed
Structure         -> Removed
Table exists      -> NO

TRUNCATE:
Data              -> All rows removed
Structure         -> Preserved
Table exists      -> YES

DELETE:
Data              -> Selected rows can be removed
Structure         -> Preserved
WHERE             -> YES


===========================================================
                    ALTER OPERATIONS
===========================================================

ADD COLUMN
-> Adds a new column.

MODIFY COLUMN
-> Changes column definition.

RENAME COLUMN
-> Changes column name.

DROP COLUMN
-> Removes a column.

ADD CONSTRAINT
-> Adds a constraint to a table.


===========================================================
                  IMPORTANT QUESTIONS
===========================================================

Q1. What is SQL?

Q2. What is DDL? List its commands.

Q3. Explain the CREATE command with syntax and example.

Q4. Write SQL to create a Student table with:
    - student_id
    - name
    - age
    - course

Q5. What is ALTER TABLE?

Q6. Write SQL to add an email column to Student.

Q7. Write SQL to modify the datatype of age.

Q8. Write SQL to rename a column.

Q9. Write SQL to drop a column.

Q10. What is the DROP command?

Q11. Differentiate between DROP and TRUNCATE.

Q12. What is TRUNCATE?

Q13. Differentiate between DELETE, DROP and TRUNCATE.

Q14. Write SQL to create a Course table and then
     modify its structure using ALTER.

Q15. Explain why TRUNCATE is considered a DDL command.

Q16. What happens to the table structure after:
     a) DROP
     b) TRUNCATE
     c) DELETE

Q17. Write a SQL script demonstrating CREATE, ALTER,
     TRUNCATE and DROP.

===========================================================
                 EXAM MEMORY TRICK
===========================================================

CREATE  = MAKE
ALTER   = CHANGE
TRUNCATE = EMPTY
DROP    = DESTROY

===========================================================
*/