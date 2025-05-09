-- =============================
-- Exam Registration System Database Schema
-- =============================

-- STUDENT TABLE
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    NSHE_Number VARCHAR(10) UNIQUE,
    Authorization_ID INT
);

-- AUTHENTICATION TABLE
CREATE TABLE Authentication (
    Authentication_ID INT PRIMARY KEY,
    CSN_Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100),
    Role VARCHAR(20) -- 'student' or 'faculty'
);

-- LOCATION TABLE
CREATE TABLE Location (
    Location_ID INT PRIMARY KEY,
    Campus_Name VARCHAR(100),
    Building_Number VARCHAR(10),
    Room_Number VARCHAR(10)
);

-- FACULTY TABLE
CREATE TABLE Faculty (
    Faculty_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Rank VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(100),
    Status VARCHAR(20),
    Hire_Date DATE,
    Role VARCHAR(20),
    Authentication_ID INT,
    FOREIGN KEY (Authentication_ID) REFERENCES Authentication(Authentication_ID)
);

-- EXAM TABLE
CREATE TABLE Exam (
    Exam_ID INT PRIMARY KEY,
    Location_ID INT,
    Exam_Date DATE,
    Exam_Name VARCHAR(100),
    Exam_Time TIME,
    Proctor_ID INT,
    Current_Count INT DEFAULT 0,
    Capacity INT DEFAULT 20,
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
    FOREIGN KEY (Proctor_ID) REFERENCES Faculty(Faculty_ID)
);

-- EXAM REGISTRATION TABLE
CREATE TABLE Exam_Registration (
    Registration_ID INT PRIMARY KEY,
    Student_ID INT,
    Exam_ID INT,
    Registration_Date DATE,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)
);

INSERT INTO Authentication (Authentication_ID, CSN_Email, Password, Role) VALUES
(1, 'asmith@csn.edu', 'password123', 'faculty'),
(2, 'bjohnson@csn.edu', 'password123', 'faculty'),
(3, 'clee@csn.edu', 'password123', 'faculty'),
(4, 'dnguyen@csn.edu', 'password123', 'faculty');

-- 6. Insert Sample Data into Faculty Table
INSERT INTO Faculty (Faculty_ID, First_Name, Last_Name, Email, Rank, Salary, Department, Status, Hire_Date, Role, Authentication_ID) VALUES
(1, 'Alice', 'Smith', 'asmith@csn.edu', 'Professor', 70000.00, 'Biology', 'Active', '2020-05-01', 'faculty', 1),
(2, 'Bob', 'Johnson', 'bjohnson@csn.edu', 'Professor', 70000.00, 'Chemistry', 'Active', '2024-08-01', 'faculty', 2),
(3, 'Carol', 'Lee', 'clee@csn.edu', 'Professor', 70000.00, 'Physics', 'Active', '2012-04-04', 'faculty', 3),
(4, 'David', 'Nguyen', 'dnguyen@csn.edu', 'Professor', 70000.00, 'Mathematics', 'Active', '2020-08-07', 'faculty', 4);

-- 7. Insert Sample Data into Location Table
INSERT INTO Location (Location_ID, Campus_Name, Building_Number, Room_Number) VALUES
(1, 'North Las Vegas', 'B', '101'),
(2, 'Henderson', 'D', '202'),
(3, 'West Charleston', 'C', '303'),
(4, 'Green Valley', 'C', '404');

-- 8. Insert Sample Data into Exam Table
INSERT INTO Exam (Exam_ID, Location_ID, Exam_Date, Exam_Name, Exam_Time, Proctor_ID, Current_Count, Capacity) VALUES
(1, 1, '2025-05-10', 'Biology 101', '09:00:00', 1, 0, 20),
(2, 2, '2025-05-11', 'Chemistry 201', '11:00:00', 2, 0, 20),
(3, 3, '2025-05-12', 'Physics 301', '13:00:00', 3, 0, 20),
(4, 4, '2025-05-13', 'Mathematics 401', '15:00:00', 4, 0, 20);