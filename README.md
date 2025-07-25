# Library Management System - SQL Project

## 📌 About
This project is a SQL-based system for managing library operations like tracking books, authors, members, and loans.

## 🛠 Tools Used
- MySQL Workbench
- dbdiagram.io

## 📁 Files Included
- `Library_Management_System_Full.sql` – SQL code for schema, sample data, views, and triggers
- `Library_Management_Project_Report.pdf` – 2-page final report
- `ER_Diagram.png` – Entity Relationship Diagram (optional)

## 📊 Features
- Normalized database design
- Overdue book tracking
- Views for borrowed books
- Trigger to restrict book copy limits

## 🧪 How to Run
1. Open SQL file in MySQL Workbench
2. Execute each section step-by-step (Tables → Inserts → Views → Triggers)


# 🎓 Student Result Processing System (SQL Project)

This project is designed to manage student academic records, calculate GPA, and generate rank lists using SQL. It simulates a university-grade database and demonstrates core SQL capabilities including schema design, joins, aggregation, and window functions.

---

## 📌 Project Overview

- **Domain**: Education
- **Tech Stack**: MySQL, SQL Workbench
- **Goal**: Automate the processing of student results with GPA and rank generation

---

## 🗂️ Database Schema

The project includes the following tables:

- `Students`: Stores student info  
- `Courses`: Contains course details and credits  
- `Semesters`: Tracks semester data  
- `Grades`: Stores each student's course-wise grades  
- `GradePoints`: Maps grade letters (A, B, C, etc.) to numeric points

---

## 🛠️ Features Implemented

- ✅ Schema design with relationships (PK, FK)
- ✅ Sample data inserted for students, courses, grades
- ✅ GPA calculation query using weighted credit system
- ✅ Rank list generation using `RANK()` window function
- ✅ Normalized structure for performance and clarity

---

## 📈 Sample Queries

### 🔹 GPA Calculation
```sql
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

