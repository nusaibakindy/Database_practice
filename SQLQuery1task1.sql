CREATE DATABASE company;


use company

CREATE TABLE Employee (
	SSN CHAR(9) PRIMARY KEY,
	Fname VARCHAR(50) NOT NULL,
	Lname VARCHAR(50) NOT NULL,
	Brith_Date DATE,
	Gender CHAR(1),
	Department_ID INT,
	Supervisor_SSN CHAR(9),
	FOREIGN KEY (Supervisor_SSN) REFERENCES Employee (SSN) 
	);


CREATE TABLE Department(
	DNUM INT PRIMARY KEY,
	DName VARCHAR(100),
	Location VARCHAR(100),
	Manager_SSN CHAR(9),
	FOREIGN KEY (Manager_SSN) REFERENCES Employee(SSN)

);

CREATE TABLE projects(
		PNumber INT PRIMARY KEY,
		Pname VARCHAR(255),
		City VARCHAR(100),
	    Department_DNUM INT,
        FOREIGN KEY (Department_DNUM) REFERENCES Department(DNUM)
);

CREATE TABLE WORK (
    SSN CHAR(9),
    PNumber INT,
    Hours_Worked INT,
    PRIMARY KEY (SSN, PNumber),
    FOREIGN KEY (SSN) REFERENCES Employee(SSN),
    FOREIGN KEY (PNumber) REFERENCES projects(PNumber)
);

CREATE TABLE Dependent (
	Dependent_Name VARCHAR(100),
	Gender CHAR(1),
	Birth_Date DATE, 
	Employee_SSN CHAR(9),
	    PRIMARY KEY (Dependent_Name, Employee_SSN),
    FOREIGN KEY (Employee_SSN) REFERENCES Employee(SSN)
);

CREATE TABLE Location (
	DUNM INT,
	Loc VARCHAR(9),
    PRIMARY KEY (DUNM,Loc),
	FOREIGN KEY (DUNM) REFERENCES Department
	);

SELECT * FROM Employee WHERE SSN = '123456789';

INSERT INTO Employee (SSN, Fname, Lname, Brith_Date, Gender, Department_ID, Supervisor_SSN)
VALUES ('123456789', 'John', 'Doe', '1985-03-15', 'M', 1, NULL);


INSERT INTO Department (DNUM, DName, Location, Manager_SSN)
VALUES (1, 'Human Resources', 'New York', '123456789');

UPDATE Employee
SET Fname = 'David', Lname = 'Miller', Gender = 'M'
WHERE SSN = '123456789';

UPDATE Employee
SET Department_ID = CASE
    WHEN Department_ID = 1 THEN 2
    WHEN Department_ID = 2 THEN 3
    ELSE Department_ID
END;