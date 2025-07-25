
-- Student Result Processing System

-- 1. Creating Tables

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(50)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE Semesters (
    semester_id INT PRIMARY KEY,
    semester_name VARCHAR(50)
);

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (semester_id) REFERENCES Semesters(semester_id)
);

CREATE TABLE GradePoints (
    grade VARCHAR(2) PRIMARY KEY,
    points DECIMAL(3,2)
);

-- 2. Inserting Data

INSERT INTO Students VALUES 
(1, 'Ravi Kumar', 'ravi@example.com', 'CSE'),
(2, 'Anjali Sharma', 'anjali@example.com', 'ECE'),
(3, 'Amit Singh', 'amit@example.com', 'ME');

INSERT INTO Courses VALUES 
(101, 'Database Management Systems', 3),
(102, 'Operating Systems', 4),
(103, 'Computer Networks', 3);

INSERT INTO Semesters VALUES 
(1, 'Semester 1'),
(2, 'Semester 2');

INSERT INTO Grades (student_id, course_id, semester_id, grade) VALUES 
(1, 101, 1, 'A'),
(1, 102, 1, 'B'),
(1, 103, 1, 'A'),
(2, 101, 1, 'B'),
(2, 102, 1, 'C'),
(2, 103, 1, 'B'),
(3, 101, 1, 'C'),
(3, 102, 1, 'D'),
(3, 103, 1, 'F');

INSERT INTO GradePoints VALUES
('A', 10), ('B', 8), ('C', 6), ('D', 4), ('F', 0);

-- 3. GPA Calculation Query

SELECT 
    s.student_id,
    s.name,
    sem.semester_name,
    ROUND(SUM(gp.points * c.credits) / SUM(c.credits), 2) AS GPA
FROM Grades g
JOIN Students s ON s.student_id = g.student_id
JOIN Courses c ON c.course_id = g.course_id
JOIN GradePoints gp ON g.grade = gp.grade
JOIN Semesters sem ON g.semester_id = sem.semester_id
GROUP BY s.student_id, sem.semester_name;

-- 4. Rank List Using Window Function

SELECT *,
       RANK() OVER (PARTITION BY semester_name ORDER BY GPA DESC) AS rank
FROM (
    SELECT 
        s.student_id,
        s.name,
        sem.semester_name,
        ROUND(SUM(gp.points * c.credits) / SUM(c.credits), 2) AS GPA
    FROM Grades g
    JOIN Students s ON s.student_id = g.student_id
    JOIN Courses c ON c.course_id = g.course_id
    JOIN GradePoints gp ON g.grade = gp.grade
    JOIN Semesters sem ON g.semester_id = sem.semester_id
    GROUP BY s.student_id, sem.semester_name
) AS GPA_Table;

-- End of SQL Script
