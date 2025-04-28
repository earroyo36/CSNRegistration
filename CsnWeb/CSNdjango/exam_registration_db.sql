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
