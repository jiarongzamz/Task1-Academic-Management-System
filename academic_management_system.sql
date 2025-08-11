-- Task 1: Academic Management System

-- 1. Creating Tables
-- 1a. Creating StudentInfo table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    PHONE_NO VARCHAR(15) NOT NULL,
    EMAIL_ID VARCHAR(100) NOT NULL,
    ADDRESS TEXT NOT NULL
);


-- 1b. Creating CoursesInfo table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100) NOT NULL,
    COURSE_INSTRUCTOR_NAME VARCHAR(100) NOT NULL
);


-- 1c. Creating EnrollmentInfo table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT NOT NULL,
    COURSE_ID INT NOT NULL,
    ENROLL_STATUS VARCHAR(20) NOT NULL CHECK (ENROLL_STATUS IN ('Enrolled', 'Not Enrolled')),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

-- Inserting into StudentInfo
INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS) VALUES
(1, 'Wang Ming', '2000-01-15', '1234567890', 'wangming@email.com', '123 Beijing Road'),
(2, 'Li Wei', '2001-03-20', '2345678901', 'liwei@email.com', '456 Shanghai Street'),
(3, 'Zhang Hua', '1999-07-10', '3456789012', 'zhanghua@email.com', '789 Guangzhou Ave');

-- Inserting into CoursesInfo
INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME) VALUES
(101, 'Database Management', 'Prof. Chen Wei'),
(102, 'Web Development', 'Prof. Liu Yang'),
(103, 'Data Structures', 'Dr. Sun Mei');

-- Inserting into EnrollmentInfo
INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS) VALUES
(1, 1, 101, 'Enrolled'),
(2, 1, 102, 'Enrolled'),
(3, 2, 101, 'Enrolled'),
(4, 3, 103, 'Enrolled');

-- 3. Retrieve Student Information
-- a) Query to retrieve student details and enrollment status
SELECT 
    s.STU_NAME,
    s.PHONE_NO,
    s.EMAIL_ID,
    e.ENROLL_STATUS,
    c.COURSE_NAME
FROM 
    StudentInfo s
LEFT JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
LEFT JOIN 
    CoursesInfo c ON e.COURSE_ID = c.COURSE_ID;

-- b) Query to retrieve courses for a specific student (using Wang Ming's ID = 1)
SELECT 
    s.STU_NAME,
    c.COURSE_NAME,
    e.ENROLL_STATUS
FROM 
    StudentInfo s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN 
    CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE 
    s.STU_ID = 1;

-- c) Query to retrieve course information
SELECT * FROM CoursesInfo;

-- d) Query to retrieve specific course information
SELECT * FROM CoursesInfo WHERE COURSE_ID = 101;

-- e) Query to retrieve multiple course information
SELECT * FROM CoursesInfo WHERE COURSE_ID IN (101, 102);

-- 4. Reporting and Analytics
-- a) Number of students enrolled in each course
SELECT 
    c.COURSE_NAME,
    COUNT(e.STU_ID) as enrolled_students
FROM 
    CoursesInfo c
LEFT JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE 
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    c.COURSE_NAME;

-- b) List of students enrolled in a specific course (using Database Management course)
SELECT 
    s.STU_NAME,
    c.COURSE_NAME
FROM 
    StudentInfo s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN 
    CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE 
    c.COURSE_ID = 101;

-- c) Count of enrolled students for each instructor
SELECT 
    c.COURSE_INSTRUCTOR_NAME,
    COUNT(DISTINCT e.STU_ID) as student_count
FROM 
    CoursesInfo c
LEFT JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
GROUP BY 
    c.COURSE_INSTRUCTOR_NAME;

-- d) List of students enrolled in multiple courses
SELECT 
    s.STU_NAME,
    COUNT(e.COURSE_ID) as course_count
FROM 
    StudentInfo s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
GROUP BY 
    s.STU_NAME
HAVING 
    COUNT(e.COURSE_ID) > 1;

-- e) Courses ordered by enrollment numbers (highest to lowest)
SELECT 
    c.COURSE_NAME,
    COUNT(e.STU_ID) as student_count
FROM 
    CoursesInfo c
LEFT JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
GROUP BY 
    c.COURSE_NAME
ORDER BY 
    student_count DESC;


