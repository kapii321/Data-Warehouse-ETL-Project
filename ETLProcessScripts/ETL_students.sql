USE DWSchemaSchool
GO

If (object_id('dbo.StudentsTemp') is not null) DROP TABLE dbo.StudentsTemp;
CREATE TABLE dbo.StudentsTemp(studentID varchar(6), SName varchar(100), SSurname varchar(100), sex varchar(1), DateOfBirth date, telephone varchar(20), email varchar(200),  city varchar(100), district varchar(100));
go


IF EXISTS (SELECT 1 FROM Students)
BEGIN
	BULK INSERT dbo.StudentsTemp
		FROM 'C:\Users\Kacper\Desktop\SQL_Students2\School_Students.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '\n',   --Use to shift the control to next row
		CODEPAGE = '65001',
		TABLOCK
		);

	BULK INSERT dbo.StudentsTemp
		FROM 'C:\Users\Kacper\Desktop\SQL_Students2\School_Students2.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '\n',   --Use to shift the control to next row
		CODEPAGE = '65001',
		TABLOCK
		);
	UPDATE StudentsTemp SET district = 'Brodwino' WHERE studentID = '948856'
	UPDATE StudentsTemp SET district = 'Suchanino' WHERE studentID = '655053'
	UPDATE StudentsTemp SET district = 'Chylonia' WHERE studentID = '828319'

END
ELSE
BEGIN
	BULK INSERT dbo.StudentsTemp
		FROM 'C:\Users\Kacper\Desktop\SQL_Students2\School_Students.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '\n',   --Use to shift the control to next row
		CODEPAGE = '65001',
		TABLOCK
		);
END


SELECT * FROM StudentsTemp
If (object_id('vETLStudents') is not null) Drop View vETLStudents;
go
CREATE VIEW vETLStudents
AS
SELECT 
s1.[studentID] as [Sindex],
[SName],
[SSurname],
CASE
WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 14 AND 15 THEN '14-15'
WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 16 AND 17 THEN '16-17'
WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 18 AND 19 THEN '18-19'
WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 20 AND 200 THEN '20+'
END AS [AgeRange],
CASE
WHEN s1.[sex] = 'F' THEN 'Female'
ELSE 'Male'
END AS [Gender],
s1.[city],
s1.[district]
FROM dbo.StudentsTemp as s1
;
go

-----------------------------------------


MERGE INTO Students as SS
USING vETLStudents as ST
ON SS.StudentIndex = ST.Sindex
WHEN Not Matched
THEN
INSERT Values (
ST.Sindex,
ST.SName,
ST.SSurname,
ST.AgeRange,
ST.Gender,
ST.city,
ST.district,
1
)
WHEN Matched -- when PID number match, 
-- but AgeRange doesn't...
AND (ST.AgeRange <> SS.AgeCategory
-- or the Position
OR ST.city <> SS.City
-- or the WorkExperience 
OR ST.district <> SS.District
-- or the BookstoreKey
OR ST.SSurname <> SS.SSurname)
THEN
UPDATE
SET SS.IsCurrent = 0
WHEN Not Matched BY Source
--AND TT.TeacherIndex != 'UNKNOWN' -- do not update the UNKNOWN tuple
THEN
UPDATE
SET SS.IsCurrent = 0
;

--------------------------------------------------------



INSERT INTO Students(
	StudentIndex,
	SName,
	SSurname,
	AgeCategory,
	Gender,
	City,
	District,
	IsCurrent
	)
	SELECT
		Sindex,
		SName,
		SSurname,
		AgeRange,
		Gender,
		city,
		district,
		1
	FROM vETLStudents
	EXCEPT
	SELECT
		StudentIndex,
		SName,
		SSurname,
		AgeCategory,
		Gender,
		City,
		District,
		1
	FROM Students

DROP TABLE dbo.StudentsTemp;
Drop View vETLStudents; 

