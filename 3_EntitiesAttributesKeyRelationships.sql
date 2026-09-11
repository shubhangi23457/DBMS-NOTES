/*
===========================================================
             ENTITIES, ATTRIBUTES, KEYS & RELATIONSHIPS
===========================================================

1. ENTITY
-----------------------------------------------------------

An entity is a real-world object or thing that can be
identified and about which data can be stored.

Examples:
- Student
- Teacher
- Course
- Employee
- Department
- Product

Example:

Student is an entity.

A particular student such as:
Student ID = 101, Name = Rahul

is an entity instance.

-----------------------------------------------------------
ENTITY SET
-----------------------------------------------------------

An entity set is a collection of similar entities.

Example:

Student entity set:
- Rahul
- Priya
- Aman
- Neha


2. ATTRIBUTES
-----------------------------------------------------------

An attribute is a property or characteristic of an entity.

Example:

Entity: Student

Attributes:
- Student_ID
- Name
- Age
- Email
- Course

Student
|
|-- Student_ID
|-- Name
|-- Age
|-- Email
|-- Course


TYPES OF ATTRIBUTES
-----------------------------------------------------------

1. SIMPLE ATTRIBUTE
   Cannot be divided further.

   Example:
   Age
   Gender


2. COMPOSITE ATTRIBUTE
   Can be divided into smaller attributes.

   Example:
   Name -> First_Name + Last_Name

   Address ->
   Street + City + State + PIN


3. SINGLE-VALUED ATTRIBUTE
   Has only one value for an entity.

   Example:
   Student_ID


4. MULTI-VALUED ATTRIBUTE
   Can have multiple values.

   Example:
   Phone_Number

   A student may have:
   - 9876543210
   - 9123456780


5. DERIVED ATTRIBUTE
   Value can be calculated from another attribute.

   Example:
   Age can be derived from Date_of_Birth.


6. STORED ATTRIBUTE
   Attribute whose value is directly stored.

   Example:
   Date_of_Birth

   Age can be calculated from Date_of_Birth.


3. KEYS
-----------------------------------------------------------

A key is an attribute or group of attributes used to
identify records uniquely or establish relationships
between tables.


1. SUPER KEY
-----------------------------------------------------------

A super key is any set of one or more attributes that can
uniquely identify a record.

Example:

Student(Student_ID, Email, Name)

Possible super keys:
- Student_ID
- Email
- Student_ID + Name
- Email + Name


2. CANDIDATE KEY
-----------------------------------------------------------

A candidate key is a minimal super key.

It uniquely identifies a record and contains no unnecessary
attributes.

Example:

Student_ID and Email may both uniquely identify students.

Therefore:
Candidate Keys = Student_ID, Email


3. PRIMARY KEY
-----------------------------------------------------------

The candidate key selected to uniquely identify records
is called the primary key.

Properties:
- Unique
- Cannot contain NULL
- Only one primary key constraint per table
- Can contain multiple columns (composite primary key)


4. ALTERNATE KEY
-----------------------------------------------------------

Candidate keys that are not selected as the primary key
are called alternate keys.

Example:

Candidate Keys:
- Student_ID
- Email

If Student_ID is selected as PRIMARY KEY,

Email becomes an ALTERNATE KEY.


5. FOREIGN KEY
-----------------------------------------------------------

A foreign key is an attribute that refers to a primary key
(or an eligible unique key, depending on DBMS rules) in
another table.

It is used to establish relationships between tables.

Example:

Student(department_id)
        |
        v
Department(department_id)


6. COMPOSITE KEY
-----------------------------------------------------------

A key made up of two or more attributes is called a
composite key.

Example:

Enrollment:
student_id + course_id

Together they uniquely identify an enrollment record.


4. RELATIONSHIPS
-----------------------------------------------------------

A relationship represents an association between two or
more entities.

Example:

Student ---- ENROLLS IN ---- Course

Student and Course are entities.
"Enrolls In" is the relationship.


TYPES OF RELATIONSHIPS
-----------------------------------------------------------

1. ONE-TO-ONE (1:1)
-------------------

One entity is related to exactly one entity.

Example:

Person ---- has ---- Passport

One person has one passport.


2. ONE-TO-MANY (1:N)
--------------------

One entity can be related to many entities.

Example:

Department ---- has ---- Students

One department can have many students.


3. MANY-TO-ONE (N:1)
--------------------

Many entities are related to one entity.

Example:

Many students belong to one department.

Student ---- belongs to ---- Department


4. MANY-TO-MANY (M:N)
---------------------

Many entities can be related to many entities.

Example:

Students ---- enroll in ---- Courses

One student can enroll in multiple courses.

One course can have multiple students.

This relationship is generally implemented using a
junction/associative table.

Example:

Student
   |
   | 
Enrollment
   |
   |
Course


5. CARDINALITY
-----------------------------------------------------------

Cardinality describes how many instances of one entity
can be associated with instances of another entity.

Common cardinalities:
- 1:1
- 1:N
- N:1
- M:N


6. PARTICIPATION
-----------------------------------------------------------

Participation describes whether every entity must
participate in a relationship.

1. TOTAL PARTICIPATION
   Every entity must participate.

2. PARTIAL PARTICIPATION
   Participation is optional.


7. ENTITY INTEGRITY
-----------------------------------------------------------

Entity integrity states that a primary key:
- Must be unique
- Cannot be NULL

This ensures every record can be uniquely identified.


8. REFERENTIAL INTEGRITY
-----------------------------------------------------------

Referential integrity ensures that a foreign key value
must refer to a valid record in the referenced table
(or be NULL when the relationship permits NULL).

Example:

If Student.department_id = 1,

Department with department_id = 1 should exist.


===========================================================
                    RUNNABLE SQL
===========================================================
*/

-- =========================================================
-- ENTITY: DEPARTMENT
-- =========================================================

CREATE DATABASE EntityRelationshipDB;

USE EntityRelationshipDB;

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE
);


-- =========================================================
-- ENTITY: STUDENT
-- Demonstrates:
-- Primary Key
-- Foreign Key
-- Attributes
-- =========================================================

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30),
    age INT CHECK (age >= 16),
    email VARCHAR(100) UNIQUE,
    department_id INT,

    FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
);


-- =========================================================
-- ENTITY: COURSE
-- =========================================================

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT CHECK (credits > 0)
);


-- =========================================================
-- RELATIONSHIP:
-- STUDENT <-> COURSE
--
-- Many-to-Many relationship
--
-- Composite Primary Key:
-- student_id + course_id
-- =========================================================

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
-- INSERT DEPARTMENT DATA
-- =========================================================

INSERT INTO Department
VALUES
(1, 'Computer Science'),
(2, 'Information Technology'),
(3, 'Electronics');


-- =========================================================
-- INSERT STUDENT DATA
-- =========================================================

INSERT INTO Student
(student_id, first_name, last_name, age, email, department_id)
VALUES
(101, 'Rahul', 'Sharma', 20, 'rahul@gmail.com', 1),
(102, 'Priya', 'Singh', 21, 'priya@gmail.com', 1),
(103, 'Aman', 'Kumar', 19, 'aman@gmail.com', 2),
(104, 'Neha', 'Patel', 20, 'neha@gmail.com', 3);


-- =========================================================
-- INSERT COURSE DATA
-- =========================================================

INSERT INTO Course
VALUES
(101, 'Database Management System', 4),
(102, 'Java Programming', 4),
(103, 'Computer Networks', 3);


-- =========================================================
-- INSERT ENROLLMENT DATA
-- =========================================================

INSERT INTO Enrollment
VALUES
(101, 101, '2026-08-01'),
(101, 102, '2026-08-01'),
(102, 101, '2026-08-02'),
(102, 103, '2026-08-02'),
(103, 102, '2026-08-03');


-- =========================================================
-- DISPLAY STUDENTS
-- =========================================================

SELECT * FROM Student;


-- =========================================================
-- DISPLAY DEPARTMENTS
-- =========================================================

SELECT * FROM Department;


-- =========================================================
-- DISPLAY COURSES
-- =========================================================

SELECT * FROM Course;


-- =========================================================
-- DISPLAY ENROLLMENTS
-- =========================================================

SELECT * FROM Enrollment;


-- =========================================================
-- ONE-TO-MANY RELATIONSHIP
-- Department -> Students
-- =========================================================

SELECT
    Department.department_name,
    Student.first_name,
    Student.last_name
FROM Department
JOIN Student
    ON Department.department_id = Student.department_id;


-- =========================================================
-- MANY-TO-MANY RELATIONSHIP
-- Students -> Courses
-- =========================================================

SELECT
    Student.first_name,
    Student.last_name,
    Course.course_name,
    Enrollment.enrollment_date
FROM Enrollment
JOIN Student
    ON Enrollment.student_id = Student.student_id
JOIN Course
    ON Enrollment.course_id = Course.course_id;


-- =========================================================
-- FIND ALL COURSES TAKEN BY RAHUL
-- =========================================================

SELECT
    Course.course_name
FROM Student
JOIN Enrollment
    ON Student.student_id = Enrollment.student_id
JOIN Course
    ON Enrollment.course_id = Course.course_id
WHERE Student.first_name = 'Rahul';


-- =========================================================
-- COUNT STUDENTS IN EACH DEPARTMENT
-- =========================================================

SELECT
    Department.department_name,
    COUNT(Student.student_id) AS total_students
FROM Department
LEFT JOIN Student
    ON Department.department_id = Student.department_id
GROUP BY Department.department_id,
         Department.department_name;


-- =========================================================
-- FIND STUDENTS ENROLLED IN MORE THAN ONE COURSE
-- =========================================================

SELECT
    Student.student_id,
    Student.first_name,
    COUNT(Enrollment.course_id) AS total_courses
FROM Student
JOIN Enrollment
    ON Student.student_id = Enrollment.student_id
GROUP BY Student.student_id,
         Student.first_name
HAVING COUNT(Enrollment.course_id) > 1;


/*
===========================================================
                    QUICK REVISION
===========================================================

ENTITY
-> Real-world object about which data is stored.

ENTITY SET
-> Collection of similar entities.

ATTRIBUTE
-> Property/characteristic of an entity.

SIMPLE ATTRIBUTE
-> Cannot be divided further.

COMPOSITE ATTRIBUTE
-> Can be divided into smaller attributes.

SINGLE-VALUED ATTRIBUTE
-> Has one value.

MULTI-VALUED ATTRIBUTE
-> Can have multiple values.

STORED ATTRIBUTE
-> Directly stored value.

DERIVED ATTRIBUTE
-> Calculated from another attribute.

SUPER KEY
-> Any set of attributes that uniquely identifies a record.

CANDIDATE KEY
-> Minimal super key.

PRIMARY KEY
-> Selected candidate key used to uniquely identify records.

ALTERNATE KEY
-> Candidate key not selected as primary key.

FOREIGN KEY
-> Attribute that references another table's key.

COMPOSITE KEY
-> Key consisting of multiple attributes.

RELATIONSHIP
-> Association between entities.

1:1
-> One-to-One

1:N
-> One-to-Many

N:1
-> Many-to-One

M:N
-> Many-to-Many

CARDINALITY
-> Number of entity instances participating in a
   relationship.

TOTAL PARTICIPATION
-> Every entity must participate.

PARTIAL PARTICIPATION
-> Participation is optional.

ENTITY INTEGRITY
-> Primary key cannot be NULL and must be unique.

REFERENTIAL INTEGRITY
-> Foreign key must reference a valid record.


===========================================================
                  IMPORTANT QUESTIONS
===========================================================

Q1. What is an entity? Give three examples.

Q2. What is the difference between an entity and an
    entity set?

Q3. Explain simple, composite, single-valued,
    multi-valued and derived attributes.

Q4. What is a key in DBMS?

Q5. Differentiate between:
    - Super Key
    - Candidate Key
    - Primary Key
    - Alternate Key
    - Foreign Key

Q6. What is a composite key? Give an example.

Q7. Explain 1:1, 1:N and M:N relationships.

Q8. What is cardinality?

Q9. Explain total and partial participation.

Q10. What is entity integrity?

Q11. What is referential integrity?

Q12. Create Student, Course and Enrollment tables
     demonstrating a many-to-many relationship.

Q13. Write a query to display students along with
     the courses they are enrolled in.

Q14. Find the number of courses taken by each student.

===========================================================
*/