--Drope the database if it exists
DROP DATABASE IF EXISTS exam_system;

-- Create the database for the exam system
CREATE DATABASE exam_system;

-- Select the exam_system database for use
USE exam_system;

-- Create the Student table to store student information
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,                 -- Unique identifier for each student
    First_Name VARCHAR(50) NOT NULL,            -- Student's first name
    Last_Name VARCHAR(50) NOT NULL,            	-- Student's last name
    Email VARCHAR(100) UNIQUE NOT NULL      	-- Student's unique email address
);

-- Create the Exam table to store exam details
CREATE TABLE Exam (
    Exam_ID INT PRIMARY KEY,                            -- Unique identifier for each exam
    Exam_Name VARCHAR(100) NOT NULL,        			-- Name of the exam (e.g., Mathematics)
    Date DATE NOT NULL,                                 -- Date of the exam
    Duration INT NOT NULL                               -- Duration of the exam in minutes
);

-- Create the Question table to store exam questions
CREATE TABLE Question (
    Question_ID INT PRIMARY KEY,          			    -- Unique identifier for each question
    Exam_ID INT,                          		  	    -- Foreign key linking to Exam table
    Question_Text TEXT NOT NULL,         		        -- Text of the question
    Marks INT NOT NULL,                     		    -- Marks allocated for the question
    FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)      -- Constraint to ensure valid Exam_ID
);

-- Create the Answer table to store student answers
CREATE TABLE Answer (
    Answer_ID INT PRIMARY KEY,         				       			  -- Unique identifier for each answer
    Student_ID INT,                        						      -- Foreign key linking to Student table
    Question_ID INT,                        						  -- Foreign key linking to Question table
    Answer_Text TEXT NOT NULL,              						  -- Text of the student's answer
    Submitted_At DATETIME NOT NULL,      			                  -- Timestamp when the answer was submitted
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),          -- Constraint for valid Student_ID
    FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID)        -- Constraint for valid Question_ID
);

-- Create the Result table to store exam results
CREATE TABLE Result (
    Result_ID INT PRIMARY KEY,             				                -- Unique identifier for each result
    Student_ID INT,                         					        -- Foreign key linking to Student table
    Exam_ID INT,                            					        -- Foreign key linking to Exam table
    Total_Marks INT NOT NULL,              				                -- Total marks obtained by the student
    Grade VARCHAR(10),                                                  -- Grade assigned (e.g., A, B)
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID), 			-- Constraint for valid Student_ID
    FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)          			-- Constraint for valid Exam_ID
);


-- Insert corrected sample data into the Student table
INSERT INTO Student (Student_ID, First_Name, Last_Name, Email) VALUES
(1, 'John', 'Sunder', 'john.Sundar@email.com'),                         -- Student 1
(2, 'Ant', 'Man', 'antman@email.com'),                                  -- Student 2
(3, 'Iron', 'Man', 'Iron_Man@email.com');                               -- Student 3

-- Insert sample data into the Exam table
INSERT INTO Exam (Exam_ID, Exam_Name, Date, Duration) VALUES
(101, 'Mathematics', '2025-06-01', 120),                                -- Exam 1: Mathematics
(102, 'Physics', '2025-06-03', 90),                                     -- Exam 2: Physics
(103, 'Chemistry', '2025-06-05', 100);                                  -- Exam 3: Chemistry

-- Insert sample data into the Question table
INSERT INTO Question (Question_ID, Exam_ID, Question_Text, Marks) VALUES
(201, 101, 'Solve the equation: 2x + 3 = 7', 5),                        -- Question for Mathematics
(202, 101, 'What is the derivative of x^2?', 10),                       -- Question for Mathematics
(203, 102, 'Define Newton’s First Law.', 8);                            -- Question for Physics

-- Insert sample data into the Answer table
INSERT INTO Answer (Answer_ID, Student_ID, Question_ID, Answer_Text, Submitted_At) VALUES
(301, 1, 201, 'x = 2', '2025-06-01 10:30:00'),           -- Answer by John for Q201
(302, 1, 202, '2x', '2025-06-01 10:45:00'),              -- Answer by John for Q202
(303, 2, 201, 'x = 3', '2025-06-01 10:35:00');           -- Answer by Yogananda for Q201

-- Insert sample data into the Result table
INSERT INTO Result (Result_ID, Student_ID, Exam_ID, Total_Marks, Grade) VALUES
(401, 1, 101, 85, 'A'),        -- Result for John in Mathematics
(402, 2, 101, 70, 'B'),        -- Result for Yogananda in Mathematics
(403, 1, 102, 90, 'A');        -- Result for John in Physics

-- Query 1: Display all records from the tables
-- This query retrieves all columns from the tables to show details

SELECT * FROM Student;

SELECT * FROM Exam;

SELECT * FROM Question;

SELECT * FROM Answer;

SELECT * FROM Result;

-- Query 2: Display a joined result of Student, Exam, and Result tables
-- This query joins the tables to show student names, exam names, marks, and grades

SELECT 
    s.Student_ID,
    s.First_Name,
    s.Last_Name,
    e.Exam_Name,
    r.Total_Marks,
    r.Grade
FROM 
    Student s
    JOIN Result r ON s.Student_ID = r.Student_ID
    JOIN Exam e ON r.Exam_ID = e.Exam_ID;