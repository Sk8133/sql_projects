
-- 📁 Library Management System — SQL Project

-- ✅ 1. Schema Design (DDL)

-- Authors Table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(100),
    nationality VARCHAR(50)
);

-- Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    author_id INT,
    total_copies INT CHECK (total_copies >= 0),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE
);

-- Loans Table
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- 🧪 2. Sample Data (INSERTS)

-- Authors
INSERT INTO Authors VALUES (1, 'J.K. Rowling', 'British');
INSERT INTO Authors VALUES (2, 'George Orwell', 'British');
INSERT INTO Authors VALUES (3, 'Chetan Bhagat', 'Indian');

-- Books
INSERT INTO Books VALUES (101, 'Harry Potter', 'Fantasy', 1, 5);
INSERT INTO Books VALUES (102, '1984', 'Dystopian', 2, 4);
INSERT INTO Books VALUES (103, 'Half Girlfriend', 'Romance', 3, 3);

-- Members
INSERT INTO Members VALUES (1001, 'Anjali Mehta', '2024-05-10');
INSERT INTO Members VALUES (1002, 'Rohan Das', '2024-06-12');

-- Loans
INSERT INTO Loans VALUES (1, 1001, 101, '2024-07-01', '2024-07-15', NULL);
INSERT INTO Loans VALUES (2, 1002, 102, '2024-07-05', '2024-07-19', '2024-07-18');

-- 🔍 3. Useful Queries

-- a. List of overdue books
SELECT L.loan_id, M.name AS member_name, B.title AS book_title, L.due_date
FROM Loans L
JOIN Members M ON L.member_id = M.member_id
JOIN Books B ON L.book_id = B.book_id
WHERE return_date IS NULL AND due_date < CURRENT_DATE;

-- b. Books borrowed by a specific member
SELECT M.name, B.title, L.loan_date
FROM Loans L
JOIN Members M ON L.member_id = M.member_id
JOIN Books B ON L.book_id = B.book_id
WHERE M.member_id = 1001;

-- c. Genre-wise lending stats
SELECT B.genre, COUNT(*) AS total_loans
FROM Loans L
JOIN Books B ON L.book_id = B.book_id
GROUP BY B.genre;

-- d. Most borrowed books
SELECT B.title, COUNT(*) AS borrow_count
FROM Loans L
JOIN Books B ON L.book_id = B.book_id
GROUP BY B.title
ORDER BY borrow_count DESC;

-- 👁️ 4. Views

-- View for currently borrowed (not returned) books
CREATE VIEW ActiveLoans AS
SELECT L.loan_id, M.name AS member_name, B.title, L.loan_date, L.due_date
FROM Loans L
JOIN Members M ON L.member_id = M.member_id
JOIN Books B ON L.book_id = B.book_id
WHERE L.return_date IS NULL;

-- ⚡ 5. Triggers

-- Trigger to warn if book copies exceed limit (hypothetical, for concept)
DELIMITER //
CREATE TRIGGER check_book_copies
BEFORE INSERT ON Books
FOR EACH ROW
BEGIN
    IF NEW.total_copies > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Book copies cannot exceed 100';
    END IF;
END;
//
DELIMITER ;
