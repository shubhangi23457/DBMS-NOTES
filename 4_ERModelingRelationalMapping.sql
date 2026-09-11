/*
===========================================================
       ER MODELING + ER-TO-RELATIONAL MAPPING
       + RELATIONAL MODEL
===========================================================

                 PART A: ER MODELING
===========================================================

1. ER MODEL
-----------------------------------------------------------

ER = Entity-Relationship

An ER model represents the structure of a database using:
- Entities
- Attributes
- Relationships
- Constraints

It is mainly used during database design.

Basic ER components:

Entity       -> Real-world object
Attribute    -> Property of an entity
Relationship -> Association between entities


2. STRONG ENTITY
-----------------------------------------------------------

A strong entity is an entity that:
- Has its own primary key.
- Can exist independently.
- Does not depend on another entity for identification.

Example:

STUDENT
-------------------
student_id (PK)
name
age
course

Student can be uniquely identified using student_id.

Therefore, Student is a strong entity.


3. WEAK ENTITY
-----------------------------------------------------------

A weak entity:
- Does not have a complete primary key of its own.
- Depends on a strong entity for identification.
- Has a partial key/discriminator.
- Must have an identifying relationship with a strong entity.

Example:

EMPLOYEE
---------
employee_id (PK)
name

DEPENDENT
---------
dependent_name
age
relationship

A dependent may be identified using:

employee_id + dependent_name

Here:
- Employee = Strong Entity
- Dependent = Weak Entity
- employee_id = Owner/identifying entity
- dependent_name = Partial Key


4. STRONG vs WEAK ENTITY
-----------------------------------------------------------

Strong Entity:
- Has its own primary key.
- Independent existence.
- Represented normally.

Weak Entity:
- Does not have a complete key.
- Depends on a strong entity.
- Uses owner's key + partial key.
- Has identifying relationship.


5. CARDINALITY
-----------------------------------------------------------

Cardinality specifies how many instances of one entity
can be associated with another entity.

Types:

1. One-to-One (1:1)
   Person ---- Passport

2. One-to-Many (1:N)
   Department ---- Student

3. Many-to-One (N:1)
   Students ---- Department

4. Many-to-Many (M:N)
   Student ---- Course


6. PARTICIPATION CONSTRAINTS
-----------------------------------------------------------

Participation specifies whether participation in a
relationship is mandatory or optional.

TWO TYPES:

A. TOTAL PARTICIPATION
----------------------

Every entity must participate in the relationship.

Example:

Every dependent must belong to an employee.

Dependent -> Employee

The dependent has total participation.


B. PARTIAL PARTICIPATION
-------------------------

Participation is optional.

Example:

An employee may or may not have a dependent.

Employee -> Dependent

Employee has partial participation.


7. CARDINALITY + PARTICIPATION
-----------------------------------------------------------

Cardinality tells:
"HOW MANY?"

Participation tells:
"IS PARTICIPATION MANDATORY?"

Example:

Department ---- has ---- Student

Cardinality:
1:N

Participation:
- A student may be required to belong to a department.
- A department may exist without students.


8. EXTENDED ER MODEL (EER)
-----------------------------------------------------------

EER = Enhanced/Extended Entity-Relationship Model

It extends the basic ER model with additional concepts.

Major concepts:
- Specialization
- Generalization
- Inheritance
- Category/Union
- Aggregation


9. SPECIALIZATION
-----------------------------------------------------------

Specialization is a top-down approach.

A general entity is divided into more specific sub-entities.

Example:

                EMPLOYEE
                   |
          -------------------
          |                 |
       MANAGER           ENGINEER

Employee = Superclass
Manager, Engineer = Subclasses

Subclasses inherit attributes of the superclass.


10. GENERALIZATION
-----------------------------------------------------------

Generalization is the opposite of specialization.

It combines multiple similar entities into a higher-level
general entity.

Example:

CAR
BIKE
BUS
 |
 v
VEHICLE

Vehicle = Generalized/Superclass entity.


11. INHERITANCE
-----------------------------------------------------------

In EER modeling, subclasses inherit:
- Attributes
- Relationships

from their superclass.

Example:

Employee:
employee_id
name

Manager inherits:
employee_id
name

and may additionally have:
bonus


12. DISJOINTNESS CONSTRAINT
-----------------------------------------------------------

Specifies whether an entity can belong to multiple
subclasses.

DISJOINT:
An entity can belong to only one subclass.

Example:
Employee can be either Manager OR Engineer.


OVERLAPPING:
An entity can belong to multiple subclasses.

Example:
A person may be both Student and Employee.


13. COMPLETENESS CONSTRAINT
-----------------------------------------------------------

Specifies whether every superclass entity must belong
to a subclass.

TOTAL SPECIALIZATION:
Every superclass entity must belong to at least one
subclass.

PARTIAL SPECIALIZATION:
Some superclass entities may not belong to any subclass.


14. AGGREGATION
-----------------------------------------------------------

Aggregation treats a relationship as a higher-level entity.

It is used when a relationship itself needs to participate
in another relationship.

Example:

Employee ---- works_on ---- Project
                  |
                  |
               monitored_by
                  |
                Manager


===========================================================
             PART B: ER-TO-RELATIONAL MAPPING
===========================================================

ER-to-Relational Mapping converts an ER diagram into
relational database tables.


1. STRONG ENTITY MAPPING
-----------------------------------------------------------

For every strong entity:
- Create one relation/table.
- Entity attributes become columns.
- Entity key becomes primary key.

Example:

STUDENT

student_id
name
age

becomes:

Student(
    student_id PRIMARY KEY,
    name,
    age
)


2. WEAK ENTITY MAPPING
-----------------------------------------------------------

For a weak entity:
- Create a separate table.
- Include its own attributes.
- Include the primary key of the owner entity.
- Combine owner key + partial key to form primary key.
- Owner key becomes foreign key.

Example:

Employee(
    employee_id PRIMARY KEY
)

Dependent(
    employee_id,
    dependent_name,
    age,
    PRIMARY KEY(employee_id, dependent_name),
    FOREIGN KEY(employee_id)
        REFERENCES Employee(employee_id)
)


3. ONE-TO-ONE MAPPING
-----------------------------------------------------------

For a 1:1 relationship:
- Place the primary key of one table as a foreign key
  in the other table.
- Usually place it on the side with total participation.

Example:

Person ---- Passport

Person(
    person_id PRIMARY KEY
)

Passport(
    passport_id PRIMARY KEY,
    person_id UNIQUE,
    FOREIGN KEY(person_id)
        REFERENCES Person(person_id)
)


4. ONE-TO-MANY MAPPING
-----------------------------------------------------------

For a 1:N relationship:
- Put the primary key of the "1" side as a foreign key
  in the "N" side.

Example:

Department ---- Student

Department(
    department_id PRIMARY KEY
)

Student(
    student_id PRIMARY KEY,
    department_id FOREIGN KEY
)


5. MANY-TO-MANY MAPPING
-----------------------------------------------------------

For an M:N relationship:
- Create a new table for the relationship.
- Include primary keys of both entities.
- Use them as foreign keys.
- Together they usually form a composite primary key.

Example:

Student ---- Enrollment ---- Course

Enrollment(
    student_id,
    course_id,
    PRIMARY KEY(student_id, course_id)
)


6. MULTI-VALUED ATTRIBUTE MAPPING
-----------------------------------------------------------

A multi-valued attribute gets a separate table.

Example:

Student
Student_ID
Phone_Number (multiple values)

becomes:

Student(
    student_id PRIMARY KEY
)

StudentPhone(
    student_id,
    phone_number,
    PRIMARY KEY(student_id, phone_number)
)


7. COMPOSITE ATTRIBUTE MAPPING
-----------------------------------------------------------

A composite attribute is divided into its individual
components.

Example:

Name
 -> First_Name
 -> Last_Name

Table:

Student(
    student_id,
    first_name,
    last_name
)


8. DERIVED ATTRIBUTE
-----------------------------------------------------------

Derived attributes are generally not stored because they
can be calculated.

Example:

Date_of_Birth -> Age

Instead of storing Age, it can be calculated from
Date_of_Birth.


===========================================================
                PART C: RELATIONAL MODEL
===========================================================

The relational model represents data using relations
(tables).


1. RELATION
-----------------------------------------------------------

A relation is a table consisting of:
- Rows
- Columns

Example:

STUDENT

ID     NAME     AGE
--------------------
101    Rahul    20
102    Priya    21

This table is a relation.


2. TUPLE
-----------------------------------------------------------

A tuple is a single row/record in a relation.

Example:

(101, Rahul, 20)

is one tuple of the Student relation.


3. ATTRIBUTE
-----------------------------------------------------------

An attribute is a column of a relation.

Example:

Student(ID, Name, Age)

ID, Name and Age are attributes.


4. DOMAIN
-----------------------------------------------------------

A domain is the set of valid values that an attribute
can contain.

Example:

Age:
Domain = integers from 16 to 100

Gender:
Domain = {Male, Female, Other}

Course:
Domain = {BCA, BTech, MCA}


5. DEGREE
-----------------------------------------------------------

Degree is the number of attributes/columns in a relation.

Example:

Student(ID, Name, Age, Course)

Degree = 4


6. CARDINALITY OF A RELATION
-----------------------------------------------------------

Cardinality is the number of tuples/rows in a relation.

If Student table contains 50 records:

Cardinality = 50


7. RELATIONAL MODEL CONSTRAINTS
-----------------------------------------------------------

Important constraints:

1. Domain Constraint
2. Key Constraint
3. Entity Integrity Constraint
4. Referential Integrity Constraint


8. DOMAIN CONSTRAINT
-----------------------------------------------------------

Every attribute value must come from its defined domain.

Example:

Age INT

Age should contain valid integer values.


9. KEY CONSTRAINT
-----------------------------------------------------------

No two tuples can have the same value for a primary key.

Example:

Student_ID must be unique.


10. ENTITY INTEGRITY
-----------------------------------------------------------

Primary key:
- Must be unique.
- Cannot be NULL.


11. REFERENTIAL INTEGRITY
-----------------------------------------------------------

A foreign key must refer to an existing value in the
referenced table, unless NULL is allowed.

Example:

Student.department_id = 10

Department 10 must exist if the foreign key is non-NULL.


12. NULL VALUE
-----------------------------------------------------------

NULL means:
- Unknown
- Missing
- Not applicable

NULL is NOT the same as:
- 0
- Empty string
- False


===========================================================
                    RUNNABLE SQL
===========================================================
*/

-- =========================================================
-- DATABASE
-- =========================================================

CREATE DATABASE ER_Relational_DB;

USE ER_Relational_DB;


-- =========================================================
-- STRONG ENTITY
-- Employee has its own primary key.
-- =========================================================

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) CHECK (salary >= 0)
);


-- =========================================================
-- WEAK ENTITY
--
-- Dependent depends on Employee.
--
-- employee_id + dependent_name
-- together identify a dependent.
-- =========================================================

CREATE TABLE Dependent (
    employee_id INT,
    dependent_name VARCHAR(50),
    age INT CHECK (age >= 0),
    relationship VARCHAR(30),

    PRIMARY KEY (employee_id, dependent_name),

    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id)
);


-- =========================================================
-- ONE-TO-MANY RELATIONSHIP
--
-- One Department -> Many Employees
-- =========================================================

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE
);


ALTER TABLE Employee
ADD department_id INT;


ALTER TABLE Employee
ADD CONSTRAINT fk_employee_department
FOREIGN KEY (department_id)
REFERENCES Department(department_id);


-- =========================================================
-- ONE-TO-ONE RELATIONSHIP
--
-- Person -> Passport
-- =========================================================

CREATE TABLE Person (
    person_id INT PRIMARY KEY,
    person_name VARCHAR(50) NOT NULL
);


CREATE TABLE Passport (
    passport_id INT PRIMARY KEY,
    passport_number VARCHAR(30) UNIQUE NOT NULL,
    person_id INT UNIQUE,

    FOREIGN KEY (person_id)
        REFERENCES Person(person_id)
);


-- =========================================================
-- MANY-TO-MANY RELATIONSHIP
--
-- Student <-> Course
-- =========================================================

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 16)
);


CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT CHECK (credits > 0)
);


CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    enrollment_date DATE,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);


-- =========================================================
-- MULTI-VALUED ATTRIBUTE
--
-- A student can have multiple phone numbers.
-- =========================================================

CREATE TABLE StudentPhone (
    student_id INT,
    phone_number VARCHAR(15),

    PRIMARY KEY (student_id, phone_number),

    FOREIGN KEY (student_id)
        REFERENCES Student(student_id)
);


-- =========================================================
-- INSERT DEPARTMENT DATA
-- =========================================================

INSERT INTO Department
VALUES
(1, 'Computer Science'),
(2, 'Information Technology'),
(3, 'Electronics');


-- =========================================================
-- INSERT EMPLOYEE DATA
-- =========================================================

INSERT INTO Employee
(employee_id, employee_name, salary, department_id)
VALUES
(101, 'Rahul', 50000, 1),
(102, 'Priya', 60000, 1),
(103, 'Aman', 45000, 2);


-- =========================================================
-- INSERT WEAK ENTITY DATA
-- =========================================================

INSERT INTO Dependent
VALUES
(101, 'Riya', 12, 'Daughter'),
(101, 'Raj', 15, 'Son'),
(102, 'Anita', 10, 'Daughter');


-- =========================================================
-- INSERT PERSON & PASSPORT DATA
-- =========================================================

INSERT INTO Person
VALUES
(1, 'Rahul'),
(2, 'Priya');


INSERT INTO Passport
VALUES
(1001, 'P123456', 1),
(1002, 'P789012', 2);


-- =========================================================
-- INSERT STUDENT DATA
-- =========================================================

INSERT INTO Student
VALUES
(201, 'Aman', 20),
(202, 'Neha', 21),
(203, 'Karan', 19);


-- =========================================================
-- INSERT COURSE DATA
-- =========================================================

INSERT INTO Course
VALUES
(301, 'DBMS', 4),
(302, 'Java', 4),
(303, 'Computer Networks', 3);


-- =========================================================
-- INSERT MANY-TO-MANY RELATIONSHIP DATA
-- =========================================================

INSERT INTO Enrollment
VALUES
(201, 301, '2026-08-01'),
(201, 302, '2026-08-01'),
(202, 301, '2026-08-02'),
(202, 303, '2026-08-02'),
(203, 302, '2026-08-03');


-- =========================================================
-- INSERT MULTI-VALUED ATTRIBUTE DATA
-- =========================================================

INSERT INTO StudentPhone
VALUES
(201, '9876543210'),
(201, '9123456780'),
(202, '9988776655');


-- =========================================================
-- DISPLAY STRONG ENTITY
-- =========================================================

SELECT * FROM Employee;


-- =========================================================
-- DISPLAY WEAK ENTITY
-- =========================================================

SELECT * FROM Dependent;


-- =========================================================
-- DISPLAY ONE-TO-MANY RELATIONSHIP
-- =========================================================

SELECT
    Employee.employee_name,
    Department.department_name
FROM Employee
JOIN Department
    ON Employee.department_id = Department.department_id;


-- =========================================================
-- DISPLAY ONE-TO-ONE RELATIONSHIP
-- =========================================================

SELECT
    Person.person_name,
    Passport.passport_number
FROM Person
JOIN Passport
    ON Person.person_id = Passport.person_id;


-- =========================================================
-- DISPLAY MANY-TO-MANY RELATIONSHIP
-- =========================================================

SELECT
    Student.student_name,
    Course.course_name,
    Enrollment.enrollment_date
FROM Enrollment
JOIN Student
    ON Enrollment.student_id = Student.student_id
JOIN Course
    ON Enrollment.course_id = Course.course_id;


-- =========================================================
-- DISPLAY MULTI-VALUED ATTRIBUTE
-- =========================================================

SELECT
    Student.student_name,
    StudentPhone.phone_number
FROM Student
JOIN StudentPhone
    ON Student.student_id = StudentPhone.student_id;


-- =========================================================
-- RELATIONAL MODEL:
-- DEGREE = NUMBER OF COLUMNS
-- =========================================================

SELECT
    COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ER_Relational_DB'
AND TABLE_NAME = 'Student';


-- =========================================================
-- RELATIONAL MODEL:
-- CARDINALITY = NUMBER OF ROWS
-- =========================================================

SELECT COUNT(*) AS total_tuples
FROM Student;


-- =========================================================
-- DOMAIN CONSTRAINT EXAMPLE
-- =========================================================

CREATE TABLE DomainExample (
    id INT PRIMARY KEY,
    age INT CHECK (age BETWEEN 16 AND 100),
    course VARCHAR(20)
);


INSERT INTO DomainExample
VALUES
(1, 20, 'BCA'),
(2, 21, 'BTech'),
(3, 19, 'MCA');


-- =========================================================
-- KEY CONSTRAINT EXAMPLE
-- =========================================================

-- id must be unique because it is the primary key.

SELECT * FROM DomainExample;


-- =========================================================
-- REFERENTIAL INTEGRITY EXAMPLE
-- =========================================================

-- The following INSERT is valid because department 1 exists.

INSERT INTO Employee
(employee_id, employee_name, salary, department_id)
VALUES
(104, 'Neha', 55000, 2);


-- =========================================================
-- JOIN TO SHOW COMPLETE INFORMATION
-- =========================================================

SELECT
    e.employee_id,
    e.employee_name,
    e.salary,
    d.department_name
FROM Employee e
JOIN Department d
    ON e.department_id = d.department_id;


/*
===========================================================
                    QUICK REVISION
===========================================================

STRONG ENTITY
-> Has its own primary key.
-> Independent existence.

WEAK ENTITY
-> Depends on a strong entity.
-> Uses owner's key + partial key.

CARDINALITY
-> Specifies HOW MANY entities participate.

1:1
-> One-to-One

1:N
-> One-to-Many

M:N
-> Many-to-Many

PARTICIPATION
-> Specifies whether participation is mandatory.

TOTAL PARTICIPATION
-> Every entity must participate.

PARTIAL PARTICIPATION
-> Participation is optional.

EER
-> Extended/Enhanced ER model.

SPECIALIZATION
-> Top-down: superclass -> subclasses.

GENERALIZATION
-> Bottom-up: similar entities -> superclass.

INHERITANCE
-> Subclass inherits attributes/relationships.

DISJOINT
-> Entity belongs to only one subclass.

OVERLAPPING
-> Entity can belong to multiple subclasses.

TOTAL SPECIALIZATION
-> Every superclass entity belongs to a subclass.

PARTIAL SPECIALIZATION
-> Some superclass entities may not belong to a subclass.


===========================================================
             ER-TO-RELATIONAL MAPPING
===========================================================

STRONG ENTITY
-> Entity becomes a table.
-> Attributes become columns.
-> Key becomes primary key.

WEAK ENTITY
-> Separate table.
-> Owner's primary key becomes foreign key.
-> Owner key + partial key = primary key.

1:1
-> Foreign key placed in one of the tables.

1:N
-> Primary key of 1-side becomes foreign key
   on N-side.

M:N
-> Create a separate relationship/junction table.
-> Both primary keys become foreign keys.
-> Usually form a composite primary key.

MULTI-VALUED ATTRIBUTE
-> Create separate table.

COMPOSITE ATTRIBUTE
-> Store its individual components.

DERIVED ATTRIBUTE
-> Usually calculated instead of stored.


===========================================================
                 RELATIONAL MODEL
===========================================================

RELATION
-> Table.

TUPLE
-> Row/record.

ATTRIBUTE
-> Column.

DOMAIN
-> Set of valid values for an attribute.

DEGREE
-> Number of columns.

CARDINALITY
-> Number of rows/tuples.

DOMAIN CONSTRAINT
-> Attribute values must belong to their valid domain.

KEY CONSTRAINT
-> Key values must uniquely identify tuples.

ENTITY INTEGRITY
-> Primary key cannot be NULL and must be unique.

REFERENTIAL INTEGRITY
-> Foreign key must reference a valid key value.


===========================================================
                  IMPORTANT QUESTIONS
===========================================================

Q1. Differentiate between strong and weak entities.

Q2. What is a weak entity? Explain with an example.

Q3. Explain 1:1, 1:N and M:N cardinality.

Q4. Differentiate between total and partial participation.

Q5. What is an Extended ER model?

Q6. Explain specialization and generalization.

Q7. What is inheritance in EER?

Q8. Differentiate between disjoint and overlapping
    specialization.

Q9. Differentiate between total and partial specialization.

Q10. Explain the steps for converting a strong entity
     into a relational table.

Q11. How is a weak entity mapped into relations?

Q12. Explain ER-to-relational mapping for 1:1, 1:N
     and M:N relationships.

Q13. How is a multi-valued attribute mapped into a
     relational database?

Q14. Define relation, tuple, attribute and domain.

Q15. What is the difference between degree and cardinality?

Q16. Explain domain, key, entity integrity and
     referential integrity constraints.

Q17. Create Student, Course and Enrollment tables to
     represent an M:N relationship.

Q18. Create Employee and Dependent tables to represent
     a strong and weak entity relationship.

Q19. Write a query to display students and their courses.

Q20. Write a query to count the number of tuples in
     the Student relation.

===========================================================
*/