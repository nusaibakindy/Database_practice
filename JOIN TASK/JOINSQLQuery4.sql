-- Schema (All levels share these tables)
-------------------------------------------------------------------------------
-- Company table
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Industry VARCHAR(50),
    City VARCHAR(50)
);
-- Job Seekers
CREATE TABLE JobSeekers (
    SeekerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    ExperienceYears INT,
    City VARCHAR(50)
);
-- Job Postings
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100),
    CompanyID INT,
    Salary DECIMAL(10, 2),
    Location VARCHAR(50),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);
-- Applications
CREATE TABLE Applications (
    AppID INT PRIMARY KEY,
    JobID INT,
    SeekerID INT,
    ApplicationDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (SeekerID) REFERENCES JobSeekers(SeekerID)
);
-- Sample Data
-------------------------------------------------------------------------
-- Companies
INSERT INTO Companies VALUES
(1, 'TechWave', 'IT', 'Muscat'),
(2, 'GreenEnergy', 'Energy', 'Sohar'),
(3, 'EduBridge', 'Education', 'Salalah');
-- Job Seekers
INSERT INTO JobSeekers VALUES
(101, 'Sara Al Busaidi', 'sara.b@example.com', 2, 'Muscat'),
(102, 'Ahmed Al Hinai', 'ahmed.h@example.com', 5, 'Nizwa'),
(103, 'Mona Al Zadjali', 'mona.z@example.com', 1, 'Salalah'),
(104, 'Hassan Al Lawati', 'hassan.l@example.com', 3, 'Muscat');
-- Jobs
INSERT INTO Jobs VALUES
(201, 'Software Developer', 1, 900, 'Muscat'),
(202, 'Data Analyst', 1, 800, 'Muscat'),
(203, 'Science Teacher', 3, 700, 'Salalah'),
(204, 'Field Engineer', 2, 950, 'Sohar');
-- Applications
INSERT INTO Applications VALUES
(301, 201, 101, '2025-05-01', 'Pending'),
(302, 202, 104, '2025-05-02', 'Shortlisted'),
(303, 203, 103, '2025-05-03', 'Rejected'),
(304, 204, 102, '2025-05-04', 'Pending');

-- Beginner Level 
-- Task1 “Who Got What?” 

SELECT js.FullName AS ApplicantName,
       j.Title AS JobTitle,
       c.Name AS CompanyName
FROM Applications a
INNER JOIN JobSeekers js ON a.SeekerID = js.SeekerID
INNER JOIN Jobs j ON a.JobID = j.JobID
INNER JOIN Companies c ON j.CompanyID = c.CompanyID;

-- Task2 “Empty Chairs” 

SELECT
    j.Title AS JobTitle,
    c.Name AS CompanyName
FROM
    Jobs j
LEFT JOIN
    Companies c ON j.CompanyID = c.CompanyID
LEFT JOIN
    Applications a ON j.JobID = a.JobID;

-- Task3 “Who Lives Where They Work?” 
SELECT
    js.FullName AS ApplicantName,
    j.Title AS JobTitle,
    js.City AS MatchingCity
FROM
    JobSeekers js
INNER JOIN
    Applications a ON js.SeekerID = a.SeekerID
INNER JOIN
    Jobs j ON a.JobID = j.JobID
INNER JOIN
    Companies c ON j.CompanyID = c.CompanyID
WHERE
    js.City = j.Location;

-- Task 4 “All Seekers with or without Applications” 
SELECT

    js.FullName AS ApplicantName,
    j.Title AS JobTitle,
    a.Status AS ApplicationStatus
FROM
    JobSeekers js
LEFT JOIN
    Applications a ON js.SeekerID = a.SeekerID
LEFT JOIN
    Jobs j ON a.JobID = j.JobID;

-- Task 5 – “Job Posting Visibility” 

SELECT 
    j.Title AS JobTitle,
    js.FullName AS ApplicantName
FROM
    Jobs j
LEFT JOIN
    Applications a ON j.JobID = a.JobID
LEFT JOIN
    JobSeekers js ON a.SeekerID = js.SeekerID;

	-- Intermediate Level 
	-- Task 6 “Ghost Seekers”

	SELECT
    js.FullName AS ApplicantName,
    js.Email AS ApplicantEmail
FROM
    JobSeekers js
LEFT JOIN
    Applications a ON js.SeekerID = a.SeekerID
WHERE
    a.AppID IS NULL;

	-- Task 7 “Vacant Companies” 

	SELECT
    c.Name AS CompanyName
FROM
    Companies c
LEFT JOIN
    Jobs j ON c.CompanyID = j.CompanyID
WHERE
    j.JobID IS NULL;
	-- Task 8 “Same City, Different People” 
	-- Task 9 “High Salary, Wrong City” 
	-- Task 10 “Unmatched Applications” 


