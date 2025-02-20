use SchoolSystem
GO

BULK INSERT dbo.Classrooms FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Classrooms.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Class FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Classes.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Students FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Students.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Teachers FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Teachers.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.DiagnosticExams FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Exams.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Grades FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_Grades.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')
BULK INSERT dbo.Is_Teaching FROM 'C:\Users\Kacper\PycharmProjects\pythonProject1\SQL_IsTeaching.csv' WITH (FIELDTERMINATOR=',', CODEPAGE = '65001')


SELECT * FROM Classrooms
SELECT * FROM Class
SELECT * FROM Students
SELECT * FROM Teachers
SELECT * FROM DiagnosticExams
SELECT * FROM Grades
SELECT * FROM Is_Teaching