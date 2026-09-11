/*
===========================================================
       FILE SYSTEMS vs DBMS, ARCHITECTURE & CONCEPTS
===========================================================

1. FILE SYSTEMS vs DBMS
-----------------------------------------------------------

FILE SYSTEM
------------
A file system stores data in separate files managed by the
operating system.

Example:
- Student.txt
- Faculty.txt
- Course.txt

Problems with File Systems:
- Data redundancy
- Data inconsistency
- Difficult data sharing
- Poor security
- Difficult backup and recovery
- Difficult concurrent access
- Program-data dependence

DBMS
----
A DBMS is software used to store, organize, retrieve,
update and manage data efficiently.

Examples:
- MySQL
- Oracle
- PostgreSQL
- SQL Server

-----------------------------------------------------------
FILE SYSTEM vs DBMS
-----------------------------------------------------------

Feature              File System          DBMS
-----------------------------------------------------------
Data redundancy      High                 Low
Data consistency     Difficult            Better
Security             Limited              High
Data sharing         Difficult            Easy
Backup/recovery      Limited              Better
Concurrency          Difficult            Supported
Relationships        Difficult            Easy
Data independence    Low                  High
Query processing     Limited              Powerful
Integrity            Difficult            Constraints
-----------------------------------------------------------


2. ADVANTAGES OF DBMS
-----------------------------------------------------------

1. Reduced Data Redundancy
   Avoids unnecessary duplication of data.

2. Improved Data Consistency
   Ensures that the same data remains consistent.

3. Data Security
   Allows authorized users to access data.

4. Data Sharing
   Multiple users can access the database.

5. Data Integrity
   Maintains accuracy and validity using constraints.

6. Backup and Recovery
   Helps recover data after system failures.

7. Concurrency Control
   Allows multiple users to work with the database safely.

8. Data Independence
   Changes in database structure can be made without
   significantly changing application programs.

9. Efficient Data Access
   SQL provides powerful ways to retrieve data.

10. Centralized Data Management
    Data can be managed from a central system.


3. APPLICATIONS OF DBMS
-----------------------------------------------------------

DBMS is used in:

- Banking
- Railway and airline reservation
- Universities and colleges
- Hospitals
- E-commerce
- Social media
- Telecommunications
- Government systems
- Library management
- Inventory management
- Payroll systems
- Online payment systems


4. DBMS ARCHITECTURE
-----------------------------------------------------------

DBMS architecture describes how users interact with
the database system.

Three-Level Architecture:

        USERS
          |
          v
   External Level
          |
          v
   Conceptual Level
          |
          v
    Internal Level
          |
          v
      DATABASE


EXTERNAL LEVEL
--------------
Also called View Level.

It describes how individual users see the database.

Different users may have different views.

Example:
- Student sees marks and attendance.
- Teacher sees student marks.
- Accountant sees fee information.


CONCEPTUAL LEVEL
----------------
Also called Logical Level.

Describes the complete logical structure of the database.

It defines:
- Tables
- Relationships
- Constraints
- Attributes

It hides physical storage details.


INTERNAL LEVEL
--------------
Also called Physical Level.

Describes how data is physically stored.

It deals with:
- Files
- Storage blocks
- Indexes
- Data structures
- Physical storage


5. DATABASE USERS
-----------------------------------------------------------

Different types of database users are:

1. DATABASE ADMINISTRATOR (DBA)
   - Manages the database.
   - Controls security.
   - Manages user permissions.
   - Handles backup and recovery.
   - Monitors performance.

2. DATABASE DESIGNERS
   - Design database structure.
   - Define tables and relationships.
   - Identify constraints.

3. APPLICATION PROGRAMMERS
   - Write programs that interact with databases.
   - Use SQL and programming languages.

4. END USERS
   - Directly use database applications.
   - Example: Bank customer or college student.

Types of End Users:

a. Naive/Parametric Users
   Use predefined applications.

b. Casual Users
   Access the database occasionally.

c. Sophisticated Users
   Understand databases and write complex queries.

d. Specialized Users
   Develop specialized database applications.


6. SCHEMA
-----------------------------------------------------------

Schema is the overall logical structure/design of a
database.

It describes:
- Tables
- Columns
- Relationships
- Constraints

Example:

Student(student_id, name, age, course)

The schema generally changes infrequently.

Schema = Structure/Design of database


7. INSTANCE
-----------------------------------------------------------

An instance is the actual data stored in the database
at a particular point in time.

Example:

Student Table

ID     Name       Course
101    Rahul      BCA
102    Priya      BCA

This actual set of records represents an instance.

Instance = Current data in database


SCHEMA vs INSTANCE
-----------------------------------------------------------

Schema:
- Structure of database
- Usually remains stable
- Example: Student(id, name, age)

Instance:
- Actual data
- Changes frequently
- Example: (101, Rahul, 20)


8. METADATA
-----------------------------------------------------------

Metadata means "data about data".

It describes the structure and properties of stored data.

Examples:
- Table names
- Column names
- Data types
- Column sizes
- Constraints
- Primary keys
- Foreign keys

Example:

Column: student_id
Data Type: INT
Constraint: PRIMARY KEY

This information is metadata.


9. DATA DICTIONARY
-----------------------------------------------------------

A data dictionary stores metadata about the database.

It may contain information about:
- Tables
- Columns
- Data types
- Constraints
- Users
- Permissions
- Indexes


10. DATA INDEPENDENCE
-----------------------------------------------------------

Data independence means changing one level of database
architecture without requiring changes at higher levels.

Two types:

1. Physical Data Independence
   Changes in physical storage do not affect the logical
   structure.

2. Logical Data Independence
   Changes in the logical structure do not significantly
   affect external views or applications.


===========================================================
                    RUNNABLE SQL
===========================================================
*/

-- Create database
CREATE DATABASE DBMS_Architecture;

USE DBMS_Architecture;


-- =========================================================
-- BASIC DATABASE STRUCTURE
-- =========================================================

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);


CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 16),
    department_id INT,
    email VARCHAR(100) UNIQUE,
    
    FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
);


-- =========================================================
-- INSERT DATA
-- =========================================================

INSERT INTO Department
VALUES
(1, 'Computer Science'),
(2, 'Information Technology'),
(3, 'Electronics');


INSERT INTO Student
VALUES
(101, 'Rahul', 20, 1, 'rahul@gmail.com'),
(102, 'Priya', 21, 1, 'priya@gmail.com'),
(103, 'Aman', 19, 2, 'aman@gmail.com'),
(104, 'Neha', 20, 3, 'neha@gmail.com');


-- =========================================================
-- VIEW DATABASE INSTANCE
-- =========================================================

SELECT * FROM Student;


-- =========================================================
-- VIEW SCHEMA / TABLE STRUCTURE
-- MySQL
-- =========================================================

DESCRIBE Student;


-- Alternative:
SHOW COLUMNS FROM Student;


-- =========================================================
-- VIEW DATABASE TABLES
-- =========================================================

SHOW TABLES;


-- =========================================================
-- VIEW METADATA
-- =========================================================

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'DBMS_Architecture';


-- =========================================================
-- VIEW CONSTRAINT INFORMATION
-- =========================================================

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'DBMS_Architecture';


-- =========================================================
-- EXAMPLE OF DATA SHARING
-- =========================================================

-- A student view
SELECT
    student_id,
    student_name,
    age
FROM Student;


-- A department-oriented view
SELECT
    student_name,
    department_id
FROM Student
WHERE department_id = 1;


-- =========================================================
-- CREATE A DATABASE VIEW
-- =========================================================

CREATE VIEW StudentBasicDetails AS
SELECT
    student_id,
    student_name,
    department_id
FROM Student;


-- View the created view
SELECT * FROM StudentBasicDetails;


-- =========================================================
-- JOIN TO SHOW RELATIONSHIP
-- =========================================================

SELECT
    Student.student_id,
    Student.student_name,
    Department.department_name
FROM Student
JOIN Department
    ON Student.department_id = Department.department_id;


-- =========================================================
-- EXAMPLE OF UPDATE
-- Demonstrates how an instance can change while the
-- table structure/schema remains the same.
-- =========================================================

UPDATE Student
SET age = 22
WHERE student_id = 102;


SELECT * FROM Student;


/*
===========================================================
                    QUICK REVISION
===========================================================

FILE SYSTEM
-> Stores data in files.

DBMS
-> Software that manages databases.

MAIN DBMS ADVANTAGES
-> Security
-> Integrity
-> Reduced redundancy
-> Data sharing
-> Backup and recovery
-> Concurrency
-> Data independence

DBMS APPLICATIONS
-> Banking
-> Hospitals
-> Education
-> E-commerce
-> Railway reservation
-> Telecom
-> Government
-> Library systems

THREE-LEVEL ARCHITECTURE
-> External Level
-> Conceptual Level
-> Internal Level

EXTERNAL LEVEL
-> User views

CONCEPTUAL LEVEL
-> Complete logical database structure

INTERNAL LEVEL
-> Physical storage details

DATABASE USERS
-> DBA
-> Database Designers
-> Application Programmers
-> End Users

SCHEMA
-> Structure/design of database

INSTANCE
-> Actual data stored at a particular time

METADATA
-> Data about data

DATA DICTIONARY
-> Stores metadata

DATA INDEPENDENCE
-> Ability to change one level without significantly
   affecting higher levels.

PHYSICAL DATA INDEPENDENCE
-> Physical storage changes do not affect logical structure.

LOGICAL DATA INDEPENDENCE
-> Logical structure changes do not significantly affect
   external views/applications.


===========================================================
                    IMPORTANT QUESTIONS
===========================================================

Q1. Differentiate between File System and DBMS.

Q2. Explain any five advantages of DBMS.

Q3. List five real-world applications of DBMS.

Q4. Explain the three levels of DBMS architecture.

Q5. What is the role of a Database Administrator?

Q6. Differentiate between Schema and Instance.

Q7. What is Metadata? Give examples.

Q8. What is a Data Dictionary?

Q9. Explain Physical and Logical Data Independence.

Q10. Explain different types of database users.

Q11. Create Student and Department tables and establish
     a relationship using a foreign key.

Q12. Write a query to display the schema information
     of a table using INFORMATION_SCHEMA.

===========================================================
*/