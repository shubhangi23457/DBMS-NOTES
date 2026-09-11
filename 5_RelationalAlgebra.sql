/*
===========================================================
                  RELATIONAL ALGEBRA
===========================================================

Relational Algebra is a procedural query language used
to perform operations on relations (tables).

It forms the theoretical foundation of relational databases
and SQL.

MAIN OPERATIONS:

1. Selection
2. Projection
3. Set Operations
4. Cartesian Product
5. Join
6. Division


===========================================================
1. SELECTION ( σ )
===========================================================

Selection is used to select ROWS from a relation that
satisfy a specified condition.

Symbol:
    σ

General form:

    σ condition (Relation)

Example:

    σ age > 20 (Student)

Meaning:
Select students whose age is greater than 20.

IMPORTANT:
Selection works on ROWS.

SQL equivalent:

    SELECT *
    FROM Student
    WHERE age > 20;


Example:

Student
--------------------------------
ID    Name      Age    Course
--------------------------------
101   Rahul     20     BCA
102   Priya     21     BCA
103   Aman      19     BTech
104   Neha      22     MCA

σ age > 20 (Student)

Result:
--------------------------------
102   Priya     21     BCA
104   Neha      22     MCA


===========================================================
2. PROJECTION ( π )
===========================================================

Projection is used to select specific COLUMNS from a
relation.

Symbol:
    π

General form:

    π attribute1, attribute2 (Relation)

Example:

    π name, course (Student)

Meaning:
Display only the Name and Course columns.

IMPORTANT:
Projection works on COLUMNS.

SQL equivalent:

    SELECT name, course
    FROM Student;

Duplicate rows are removed in relational algebra
projection.

In SQL, DISTINCT can be used to explicitly remove
duplicates:

    SELECT DISTINCT name, course
    FROM Student;


===========================================================
SELECTION vs PROJECTION
===========================================================

SELECTION:
-> Selects rows.
-> Uses conditions.
-> Symbol = σ
-> SQL = WHERE

PROJECTION:
-> Selects columns.
-> Symbol = π
-> SQL = SELECT


===========================================================
3. SET OPERATIONS
===========================================================

Set operations combine the results of two compatible
relations.

Main set operations:

1. UNION
2. INTERSECTION
3. SET DIFFERENCE


IMPORTANT:
For UNION, INTERSECTION and DIFFERENCE, the relations
should generally be union-compatible.

Union compatibility means:
- Same number of attributes
- Corresponding attributes have compatible domains/types


-----------------------------------------------------------
A. UNION ( ∪ )
-----------------------------------------------------------

Returns tuples that occur in either relation or both.

Symbol:

    R ∪ S

Example:

    BCA_Students ∪ BTech_Students

SQL:

    SELECT name FROM BCA_Students
    UNION
    SELECT name FROM BTech_Students;


-----------------------------------------------------------
B. INTERSECTION ( ∩ )
-----------------------------------------------------------

Returns tuples that occur in BOTH relations.

Symbol:

    R ∩ S

SQL:

    SELECT name FROM Student
    WHERE name IN
    (
        SELECT name FROM AnotherStudent
    );

Or, where supported:

    SELECT name FROM Student
    INTERSECT
    SELECT name FROM AnotherStudent;


-----------------------------------------------------------
C. SET DIFFERENCE ( − )
-----------------------------------------------------------

Returns tuples that exist in the first relation but not
in the second relation.

Symbol:

    R − S

Example:

    Student − Graduated_Students

Meaning:
Students who have not graduated.

SQL:

    SELECT name FROM Student
    EXCEPT
    SELECT name FROM Graduated_Students;

In MySQL, EXCEPT support depends on the version.


===========================================================
4. CARTESIAN PRODUCT ( × )
===========================================================

Cartesian Product combines every tuple of one relation
with every tuple of another relation.

Symbol:

    R × S

If:

R has 3 rows
S has 4 rows

Then:

R × S has 3 × 4 = 12 rows.

Example:

Student × Course

Every student is combined with every course.

SQL equivalent:

    SELECT *
    FROM Student
    CROSS JOIN Course;


Cartesian Product is often used as the foundation for
understanding JOIN operations.


===========================================================
5. JOIN
===========================================================

A JOIN combines related tuples from two or more relations
based on a condition.

General relational algebra form:

    R ⋈ condition S

SQL:

    SELECT *
    FROM R
    JOIN S
    ON condition;


-----------------------------------------------------------
A. THETA JOIN
-----------------------------------------------------------

A theta join uses comparison operators such as:

=
<
>
<=
>=
<>

Example:

    Student ⋈ Student.dept_id = Department.dept_id Department


-----------------------------------------------------------
B. EQUI JOIN
-----------------------------------------------------------

An equi join is a theta join where the condition uses
equality (=).

Example:

    Student ⋈ Student.dept_id = Department.dept_id Department


-----------------------------------------------------------
C. NATURAL JOIN
-----------------------------------------------------------

Natural join automatically joins relations using columns
with the same name.

Symbol:

    R ⋈ S

Example:

    Student ⋈ Department

if both tables contain department_id.

SQL:

    SELECT *
    FROM Student
    NATURAL JOIN Department;


Natural join should be used carefully because it depends
on matching column names.


-----------------------------------------------------------
D. INNER JOIN
-----------------------------------------------------------

Returns only matching records from both tables.

SQL:

    SELECT *
    FROM Student
    INNER JOIN Department
    ON Student.department_id = Department.department_id;


-----------------------------------------------------------
E. LEFT OUTER JOIN
-----------------------------------------------------------

Returns:
- All rows from the left table
- Matching rows from the right table

If no match exists, NULL is returned for right-side
columns.


-----------------------------------------------------------
F. RIGHT OUTER JOIN
-----------------------------------------------------------

Returns:
- All rows from the right table
- Matching rows from the left table.


===========================================================
6. DIVISION ( ÷ )
===========================================================

Division is used for queries involving:

"Find entities that are related to ALL entities
in another relation."

It is one of the more difficult relational algebra
operations.

Example:

StudentCourse(Student, Course)

RequiredCourse(Course)

Question:

Find students who have completed ALL required courses.

Relational Algebra:

    StudentCourse ÷ RequiredCourse

Result:
Students who are associated with every course in
RequiredCourse.

-----------------------------------------------------------
SIMPLE EXAMPLE
-----------------------------------------------------------

StudentCourse:

Student     Course
-------------------------
Rahul       DBMS
Rahul       Java
Rahul       Networks
Priya       DBMS
Priya       Java
Aman        DBMS

RequiredCourse:

Course
----------------
DBMS
Java

Division:

StudentCourse ÷ RequiredCourse

Result:

Student
----------------
Rahul
Priya

Rahul has DBMS AND Java.
Priya has DBMS AND Java.
Aman has only DBMS.

Therefore Aman is not included.


===========================================================
RELATIONAL ALGEBRA SYMBOLS - QUICK TABLE
===========================================================

Operation             Symbol
--------------------------------
Selection              σ
Projection             π
Union                  ∪
Intersection           ∩
Difference             −
Cartesian Product      ×
Join                   ⋈
Division               ÷


===========================================================
IMPORTANT DIFFERENCES
===========================================================

SELECTION
-> Rows
-> Condition
-> σ
-> WHERE

PROJECTION
-> Columns
-> π
-> SELECT

UNION
-> Combines results
-> Removes duplicates

INTERSECTION
-> Common tuples

DIFFERENCE
-> Tuples in first relation but not second

CARTESIAN PRODUCT
-> Every row of R with every row of S

JOIN
-> Combines related rows based on a condition

DIVISION
-> Finds entities related to ALL required values


===========================================================
                    RUNNABLE SQL
===========================================================
*/

CREATE DATABASE RelationalAlgebraDB;

USE RelationalAlgebraDB;


-- =========================================================
-- STUDENT RELATION
-- =========================================================

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT,
    department_id INT
);


-- =========================================================
-- DEPARTMENT RELATION
-- =========================================================

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);


-- =========================================================
-- COURSE RELATION
-- =========================================================

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL
);


-- =========================================================
-- STUDENT-COURSE RELATION
-- Used for MANY-TO-MANY relationship
-- =========================================================

CREATE TABLE StudentCourse (
    student_id INT,
    course_id INT,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);


-- =========================================================
-- REQUIRED COURSES
-- Used to demonstrate DIVISION
-- =========================================================

CREATE TABLE RequiredCourse (
    course_id INT PRIMARY KEY,

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
VALUES
(101, 'Rahul', 20, 1),
(102, 'Priya', 21, 1),
(103, 'Aman', 19, 2),
(104, 'Neha', 22, 3);


-- =========================================================
-- INSERT COURSE DATA
-- =========================================================

INSERT INTO Course
VALUES
(201, 'DBMS'),
(202, 'Java'),
(203, 'Networks'),
(204, 'Operating Systems');


-- =========================================================
-- INSERT STUDENT-COURSE DATA
-- =========================================================

INSERT INTO StudentCourse
VALUES
(101, 201), -- Rahul -> DBMS
(101, 202), -- Rahul -> Java
(101, 203), -- Rahul -> Networks

(102, 201), -- Priya -> DBMS
(102, 202), -- Priya -> Java

(103, 201), -- Aman -> DBMS

(104, 201), -- Neha -> DBMS
(104, 202), -- Neha -> Java
(104, 203), -- Neha -> Networks
(104, 204); -- Neha -> OS


-- =========================================================
-- REQUIRED COURSES
-- =========================================================

INSERT INTO RequiredCourse
VALUES
(201),
(202);


-- =========================================================
-- 1. SELECTION
-- Relational Algebra:
--
-- σ age > 20 (Student)
--
-- SQL:
-- =========================================================

SELECT *
FROM Student
WHERE age > 20;


-- =========================================================
-- SELECTION WITH MULTIPLE CONDITIONS
--
-- σ age > 19 AND department_id = 1 (Student)
-- =========================================================

SELECT *
FROM Student
WHERE age > 19
AND department_id = 1;


-- =========================================================
-- 2. PROJECTION
--
-- Relational Algebra:
--
-- π student_name, age (Student)
-- =========================================================

SELECT student_name, age
FROM Student;


-- =========================================================
-- PROJECTION WITHOUT DUPLICATES
-- =========================================================

SELECT DISTINCT department_id
FROM Student;


-- =========================================================
-- 3. UNION
--
-- Find students from department 1 or department 2.
--
-- Both queries return the same number/type of columns.
-- =========================================================

SELECT student_name
FROM Student
WHERE department_id = 1

UNION

SELECT student_name
FROM Student
WHERE department_id = 2;


-- =========================================================
-- 4. INTERSECTION
--
-- Find students whose ID exists in both conditions.
--
-- MySQL-compatible approach using INNER JOIN.
-- =========================================================

SELECT DISTINCT s1.student_id
FROM Student s1
INNER JOIN Student s2
    ON s1.student_id = s2.student_id
WHERE s1.age >= 20
AND s2.department_id = 1;


-- =========================================================
-- 5. SET DIFFERENCE
--
-- Find students NOT belonging to department 1.
-- =========================================================

SELECT student_id
FROM Student
WHERE department_id <> 1;


-- =========================================================
-- 6. CARTESIAN PRODUCT
--
-- Every student is combined with every course.
-- =========================================================

SELECT
    Student.student_name,
    Course.course_name
FROM Student
CROSS JOIN Course;


-- =========================================================
-- 7. INNER JOIN
--
-- Student ⋈ Department
-- =========================================================

SELECT
    Student.student_id,
    Student.student_name,
    Department.department_name
FROM Student
INNER JOIN Department
    ON Student.department_id = Department.department_id;


-- =========================================================
-- 8. EQUI JOIN
--
-- Join using equality condition.
-- =========================================================

SELECT
    s.student_name,
    d.department_name
FROM Student s
JOIN Department d
    ON s.department_id = d.department_id;


-- =========================================================
-- 9. THETA JOIN
--
-- Join using a comparison condition.
--
-- Here, students are compared with departments based on
-- department IDs.
-- =========================================================

SELECT
    s.student_name,
    d.department_name
FROM Student s
JOIN Department d
    ON s.department_id >= d.department_id;


-- =========================================================
-- 10. LEFT OUTER JOIN
--
-- Displays every student, even if a matching department
-- does not exist.
-- =========================================================

SELECT
    s.student_name,
    d.department_name
FROM Student s
LEFT JOIN Department d
    ON s.department_id = d.department_id;


-- =========================================================
-- 11. RIGHT OUTER JOIN
--
-- Displays every department, even if it has no student.
-- =========================================================

SELECT
    s.student_name,
    d.department_name
FROM Student s
RIGHT JOIN Department d
    ON s.department_id = d.department_id;


-- =========================================================
-- 12. NATURAL JOIN
--
-- Both tables would need a column with the same name.
-- =========================================================

SELECT *
FROM Student
NATURAL JOIN Department;


-- =========================================================
-- 13. JOIN STUDENTS WITH COURSES
-- =========================================================

SELECT
    s.student_name,
    c.course_name
FROM Student s
JOIN StudentCourse sc
    ON s.student_id = sc.student_id
JOIN Course c
    ON sc.course_id = c.course_id;


-- =========================================================
-- 14. DIVISION
--
-- Find students who have completed ALL required courses.
--
-- Required courses:
-- DBMS
-- Java
--
-- Rahul -> DBMS + Java + Networks
-- Priya -> DBMS + Java
-- Aman  -> DBMS only
-- Neha  -> DBMS + Java + Networks + OS
--
-- Expected result:
-- Rahul
-- Priya
-- Neha
-- =========================================================

SELECT
    s.student_id,
    s.student_name
FROM Student s
WHERE NOT EXISTS
(
    SELECT rc.course_id
    FROM RequiredCourse rc
    WHERE NOT EXISTS
    (
        SELECT sc.course_id
        FROM StudentCourse sc
        WHERE sc.student_id = s.student_id
        AND sc.course_id = rc.course_id
    )
);


-- =========================================================
-- ALTERNATIVE DIVISION QUERY USING GROUP BY
-- =========================================================

SELECT
    s.student_id,
    s.student_name
FROM Student s
JOIN StudentCourse sc
    ON s.student_id = sc.student_id
JOIN RequiredCourse rc
    ON sc.course_id = rc.course_id
GROUP BY
    s.student_id,
    s.student_name
HAVING COUNT(DISTINCT sc.course_id)
       =
       (SELECT COUNT(*) FROM RequiredCourse);


/*
===========================================================
                    QUICK REVISION
===========================================================

SELECTION (σ)
-> Selects rows.
-> Uses conditions.

PROJECTION (π)
-> Selects columns.
-> Removes duplicate tuples in relational algebra.

UNION (∪)
-> Tuples from either relation.
-> Relations must be union-compatible.

INTERSECTION (∩)
-> Tuples common to both relations.

DIFFERENCE (−)
-> Tuples in first relation but not second.

CARTESIAN PRODUCT (×)
-> Every tuple of first relation paired with every tuple
   of second relation.

JOIN (⋈)
-> Combines related tuples.

THETA JOIN
-> Join using any comparison operator.

EQUI JOIN
-> Join using =.

NATURAL JOIN
-> Automatically joins columns having the same name.

INNER JOIN
-> Returns matching rows.

LEFT JOIN
-> All rows from left + matching rows from right.

RIGHT JOIN
-> All rows from right + matching rows from left.

DIVISION (÷)
-> Used for "FOR ALL" queries.
-> Finds entities associated with every value in another
   relation.


===========================================================
                 VERY IMPORTANT EXAM POINT
===========================================================

Remember:

σ = ROWS
π = COLUMNS
∪ = EITHER / COMBINE
∩ = COMMON
− = FIRST BUT NOT SECOND
× = EVERY COMBINATION
⋈ = RELATED DATA
÷ = FOR ALL


===========================================================
                  IMPORTANT QUESTIONS
===========================================================

Q1. What is Relational Algebra?

Q2. Explain Selection with an example.

Q3. Explain Projection with an example.

Q4. Differentiate between Selection and Projection.

Q5. What is Union? State the condition for union
    compatibility.

Q6. Explain Intersection and Set Difference.

Q7. What is Cartesian Product?

Q8. If relation R has 5 tuples and relation S has
    4 tuples, how many tuples will R × S contain?

Q9. What is a Join?

Q10. Differentiate between Theta Join and Equi Join.

Q11. What is Natural Join?

Q12. Differentiate between Inner Join, Left Join and
     Right Join.

Q13. Explain Relational Algebra Division with an example.

Q14. Write relational algebra expressions for:

    a) Students older than 20.
    b) Display only student names.
    c) Students belonging to Computer Science.
    d) Students and their departments.

Q15. Write relational algebra for:

    "Find students who have completed ALL required courses."

Q16. Convert the following relational algebra expression
     into SQL:

     σ age > 20 (Student)

Q17. Convert the following into SQL:

     π student_name, age (Student)

Q18. Write an SQL query demonstrating Cartesian Product.

Q19. Write an SQL query demonstrating an Equi Join.

Q20. Write an SQL query for a Division-type
     "for all" problem.

===========================================================
*/