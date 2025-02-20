use SchoolSystem
GO

BULK INSERT dbo.DiagnosticExams FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Exams2.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Grades FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Grades2.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Is_Teaching FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_IsTeaching2.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Students FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Students2.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Teachers FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Teachers2.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')



UPDATE Classrooms SET Room_number = 1000 WHERE Room_number = 900
UPDATE Classrooms SET Room_number = 1001 WHERE Room_number = 902
UPDATE Classrooms SET Room_number = 1002 WHERE Room_number = 903
UPDATE Classrooms SET Room_number = 1004 WHERE Room_number = 905

UPDATE Class SET Specialization = 'Computer Science' WHERE Class_Name = '0I'
UPDATE Class SET Specialization = 'Mathematics' WHERE Class_Name = '2N'
UPDATE Class SET Specialization = 'Geographic' WHERE Class_Name = '7D'
UPDATE Class SET Specialization = 'General' WHERE Class_Name = '8R'
UPDATE Class SET Specialization = 'Linguistics' WHERE Class_Name = '1K'

SELECT * FROM Class
SELECT * FROM Classrooms
SELECT * FROM Grades
SELECT * FROM DiagnosticExams
SELECT * FROM Is_Teaching
SELECT * FROM Students
SELECT * FROM Teachers



