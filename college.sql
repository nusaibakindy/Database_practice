-- Create the main database
CREATE DATABASE CollegeDB;
GO
USE CollegeDB;
GO
-- Department Table
CREATE TABLE Department (
  Department_id INT PRIMARY KEY,
  D_name VARCHAR(50) NOT NULL
);
-- Faculty Table
CREATE TABLE Faculty (
  F_id INT PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
  Mobile_no VARCHAR(15),
  Department INT,
  Salary DECIMAL(10, 2),
  FOREIGN KEY (Department) REFERENCES Department(Department_id)
);
-- Hostel Table
CREATE TABLE Hostel (
  Hostel_id INT PRIMARY KEY,
  Hostel_name VARCHAR(50) NOT NULL,
  City VARCHAR(50),
  State VARCHAR(50),
  Address VARCHAR(100),
  Pin_code VARCHAR(10),
  No_of_seats INT DEFAULT 0
);
-- Student Table
CREATE TABLE Student (
  S_id INT PRIMARY KEY,
  F_name VARCHAR(30),
  L_name VARCHAR(30),
  Phone_no VARCHAR(15),
  DOB DATE,
  Age AS DATEDIFF(YEAR, DOB, GETDATE()),
  Department INT,
  Hostel_id INT,
  FOREIGN KEY (Department) REFERENCES Department(Department_id),
  FOREIGN KEY (Hostel_id) REFERENCES Hostel(Hostel_id)
);
-- Course Table
CREATE TABLE Course (
  Course_id INT PRIMARY KEY,
  Course_name VARCHAR(50),
  Duration VARCHAR(20),
  Department_id INT,
  FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);
-- Subject Table
CREATE TABLE Subject (
  Subject_id INT PRIMARY KEY,
  Subject_name VARCHAR(50)
);
-- Exam Table
CREATE TABLE Exam (
  Exam_code INT PRIMARY KEY,
  Exam_date DATE,
  Exam_time TIME,
  Room VARCHAR(20),
  Department_id INT,
  FOREIGN KEY (Department_id) REFERENCES Department(Department_id)
);
-- Enrolled Table (M:N between Student and Course)
CREATE TABLE Enrolled (
  S_id INT,
  Course_id INT,
  PRIMARY KEY (S_id, Course_id),
  FOREIGN KEY (S_id) REFERENCES Student(S_id),
  FOREIGN KEY (Course_id) REFERENCES Course(Course_id)
);
-- Takes_Exam Table (M:N between Student and Exam)
CREATE TABLE Takes_Exam (
  S_id INT,
  Exam_code INT,
  PRIMARY KEY (S_id, Exam_code),
  FOREIGN KEY (S_id) REFERENCES Student(S_id),
  FOREIGN KEY (Exam_code) REFERENCES Exam(Exam_code)
);
-- Takes_Subject Table (M:N between Student and Subject)
CREATE TABLE Takes_Subject (
  S_id INT,
  Subject_id INT,
  PRIMARY KEY (S_id, Subject_id),
  FOREIGN KEY (S_id) REFERENCES Student(S_id),
  FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);
-- Teaches Table (1:N between Faculty and Subject)
CREATE TABLE Teaches (
  F_id INT,
  Subject_id INT,
  PRIMARY KEY (F_id, Subject_id),
  FOREIGN KEY (F_id) REFERENCES Faculty(F_id),
  FOREIGN KEY (Subject_id) REFERENCES Subject(Subject_id)
);