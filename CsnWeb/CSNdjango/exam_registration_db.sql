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
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
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
(4, 'dnguyen@csn.edu', 'password123', 'faculty'),

-- Students (use NSHE# for email and password)
(5, '1000000001@student.csn.edu', '1000000001', 'student'),
(6, '1000000002@student.csn.edu', '1000000002', 'student'),
(7, '1000000003@student.csn.edu', '1000000003', 'student')
(8, '1000000004@student.csn.edu', '1000000004', 'student'),
(9, '1000000005@student.csn.edu', '1000000005', 'student'),
(10, '1000000006@student.csn.edu', '1000000006', 'student'),
(11, '1000000007@student.csn.edu', '1000000007', 'student'),
(12, '1000000008@student.csn.edu', '1000000008', 'student'),

(13, '1000000009@student.csn.edu', '1000000009', 'student'),
(14, '1000000010@student.csn.edu', '1000000010', 'student'),
(15, '1000000011@student.csn.edu', '1000000011', 'student'),
(16, '1000000012@student.csn.edu', '1000000012', 'student'),
(17, '1000000013@student.csn.edu', '1000000013', 'student'),

(18, '1000000014@student.csn.edu', '1000000014', 'student'),
(19, '1000000015@student.csn.edu', '1000000015', 'student'),
(20, '1000000016@student.csn.edu', '1000000016', 'student'),
(21, '1000000017@student.csn.edu', '1000000017', 'student'),
(22, '1000000018@student.csn.edu', '1000000018', 'student'),

(23, '1000000019@student.csn.edu', '1000000019', 'student'),
(24, '1000000020@student.csn.edu', '1000000020', 'student'),
(25, '1000000021@student.csn.edu', '1000000021', 'student'),
(26, '1000000022@student.csn.edu', '1000000022', 'student'),
(27, '1000000023@student.csn.edu', '1000000023', 'student'),

(28, '1000000024@student.csn.edu', '1000000024', 'student'),
(29, '1000000025@student.csn.edu', '1000000025', 'student'),
(30, '1000000026@student.csn.edu', '1000000026', 'student'),
(31, '1000000027@student.csn.edu', '1000000027', 'student'),
(32, '1000000028@student.csn.edu', '1000000028', 'student');

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

INSERT INTO Student (Student_ID, First_Name, Last_Name, Email, NSHE_Number, Authorization_ID) VALUES
(5, 'Tyler', 'Smith', '1000000001@student.csn.edu', '1000000001', 5),
(6, 'Lila', 'Evans', '1000000002@student.csn.edu', '1000000002', 6),
(7, 'Quinn', 'Ortiz', '1000000003@student.csn.edu', '1000000003', 7),
(8, 'Jade', 'Martinez', '1000000004@student.csn.edu', '1000000004', 8),
(9, 'Jade', 'Garcia', '1000000005@student.csn.edu', '1000000005', 9),

(10, 'George', 'Nguyen', '1000000006@student.csn.edu', '1000000006', 10),
(11, 'Yasmin', 'Robinson', '1000000007@student.csn.edu', '1000000007', 11),
(12, 'Alex', 'Chen', '1000000008@student.csn.edu', '1000000008', 12),
(13, 'Victor', 'Patel', '1000000009@student.csn.edu', '1000000009', 13),
(14, 'Carlos', 'Anderson', '1000000010@student.csn.edu', '1000000010', 14),

(15, 'Paula', 'Williams', '1000000011@student.csn.edu', '1000000011', 15),
(16, 'Uma', 'Lopez', '1000000012@student.csn.edu', '1000000012', 16),
(17, 'Sophie', 'Brown', '1000000013@student.csn.edu', '1000000013', 17),
(18, 'Kevin', 'Garcia', '1000000014@student.csn.edu', '1000000014', 18),
(19, 'Fatima', 'Uddin', '1000000015@student.csn.edu', '1000000015', 19),

(20, 'Omar', 'Taylor', '1000000016@student.csn.edu', '1000000016', 20),
(21, 'Briana', 'Vasquez', '1000000017@student.csn.edu', '1000000017', 21),
(22, 'Mason', 'Hernandez', '1000000018@student.csn.edu', '1000000018', 22),
(23, 'Ravi', 'Johnson', '1000000019@student.csn.edu', '1000000019', 23),
(24, 'Wendy', 'Kim', '1000000020@student.csn.edu', '1000000020', 24),

(25, 'Xavier', 'Martinez', '1000000021@student.csn.edu', '1000000021', 25),
(26, 'Isaac', 'Nguyen', '1000000022@student.csn.edu', '1000000022', 26),
(27, 'Diana', 'Ortiz', '1000000023@student.csn.edu', '1000000023', 27),
(28, 'Briana', 'Smith', '1000000024@student.csn.edu', '1000000024', 28),
(29, 'Nina', 'Vasquez', '1000000025@student.csn.edu', '1000000025', 29),

(30, 'Ethan', 'Taylor', '1000000026@student.csn.edu', '1000000026', 30),
(31, 'Hannah', 'Brown', '1000000027@student.csn.edu', '1000000027', 31),
(32, 'Mason', 'Lee', '1000000028@student.csn.edu', '1000000028', 32);



INSERT INTO Exam_Registration (Registration_ID, Student_ID, Exam_ID, Registration_Date) VALUES
(4, 5, 1, '2025-05-01'),
(5, 6, 1, '2025-05-01'),
(6, 7, 1, '2025-05-01'),
(7, 8, 1, '2025-05-01'),
(8, 9, 1, '2025-05-01'),

(9, 10, 2, '2025-05-01'),
(10, 11, 2, '2025-05-01'),
(11, 12, 2, '2025-05-01'),
(12, 13, 2, '2025-05-01'),
(13, 14, 2, '2025-05-01'),

(14, 15, 3, '2025-05-01'),
(15, 16, 3, '2025-05-01'),
(16, 17, 3, '2025-05-01'),
(17, 18, 3, '2025-05-01'),
(18, 19, 3, '2025-05-01'),

(19, 20, 4, '2025-05-01'),
(20, 21, 4, '2025-05-01'),
(21, 22, 4, '2025-05-01'),
(22, 23, 4, '2025-05-01'),
(23, 24, 4, '2025-05-01'),

(24, 25, 5, '2025-05-01'),
(25, 26, 5, '2025-05-01'),
(26, 27, 5, '2025-05-01'),
(27, 28, 5, '2025-05-01'),
(28, 29, 5, '2025-05-01'),
(29, 30, 5, '2025-05-01'),
(30, 31, 5, '2025-05-01'),
(31, 32, 5, '2025-05-01');

