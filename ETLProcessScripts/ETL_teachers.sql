USE DWSchemaSchool
GO

If (object_id('dbo.TeachersTemp') is not null) DROP TABLE dbo.TeachersTemp;
CREATE TABLE dbo.TeachersTemp(teacherID varchar(6), TName varchar(100), TSurname varchar(100), Title varchar(30), begginingDate date, city varchar(100), district varchar(100), sex varchar(1), DateOfBirth date);
go

IF EXISTS (SELECT 1 FROM Teachers)
BEGIN
	BULK INSERT dbo.TeachersTemp
		FROM 'C:\Users\Kacper\Desktop\SQL_Students2\School_Teachers.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '\n',   --Use to shift the control to next row
		CODEPAGE = '65001',
		TABLOCK
		);

	BULK INSERT dbo.TeachersTemp
        FROM 'C:\Users\Kacper\Desktop\SQL_Students2\School_Teachers2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',  --CSV field delimiter
            ROWTERMINATOR = '\n',   --Use to shift the control to next row
            CODEPAGE = '65001',
            TABLOCK
        );
	UPDATE TeachersTemp SET Title = 'MSc' WHERE teacherID = '144351'
	UPDATE TeachersTemp SET Title = 'Phd' WHERE teacherID = '152117'
	UPDATE TeachersTemp SET district = 'Oliwa' WHERE teacherID = '187184'

END
ELSE
BEGIN
	BULK INSERT dbo.TeachersTemp
		FROM 'C:\Users\Kacper\Desktop\SQL_Students2\School_Teachers.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '\n',   --Use to shift the control to next row
		CODEPAGE = '65001',
		TABLOCK
		);
END


SELECT * FROM TeachersTemp
If (object_id('vETLTeachers') is not null) Drop View vETLTeachers;
go
CREATE VIEW vETLTeachers
AS
SELECT 
	t1.[teacherID] as [Tindex],
	[Tname],
	[TSurname],
	[Title],
	CASE
		WHEN t1.[sex] = 'F' THEN 'Female'
		ELSE 'Male'
	END AS [Gender],
	CASE
		WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 32 AND 35 THEN '32-35'
		WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 36 AND 39 THEN '36-39'
		WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 40 AND 45 THEN '40-45'
		WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 46 AND 49 THEN '46-49'
		WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 50 AND 55 THEN '50-55'
		WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 56 AND 59 THEN '56-59'
		WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 60 AND 65 THEN '60-65'
		WHEN DATEDIFF(year, [DateOfBirth], CURRENT_TIMESTAMP) BETWEEN 66 AND 200 THEN '65+'
	END AS [AgeRange],
	t1.[city],
	t1.[district]
FROM dbo.TeachersTemp as t1
;
go

-----------------------------------------


MERGE INTO Teachers as TT
	USING vETLTeachers as ST
		ON TT.TeacherIndex = ST.Tindex
			WHEN Not Matched
				THEN
					INSERT Values (
					ST.Tindex,
					ST.TName,
					ST.TSurname,
					ST.Title,
					ST.Gender,
					ST.AgeRange,
					ST.city,
					ST.district,
					1
					)
			WHEN Matched -- when PID number match, 
			-- but AgeRange doesn't...
				AND (ST.AgeRange <> TT.AgeCategory
			-- or the Education level...
				OR ST.Title <> TT.Title
			-- or the Position
				OR ST.city <> TT.City
			-- or the WorkExperience 
				OR ST.district <> TT.District
			-- or the BookstoreKey
				OR ST.TSurname <> TT.TSurname)
			THEN
				UPDATE
				SET TT.IsCurrent = 0
				--INSERT
			WHEN Not Matched BY Source
			--AND TT.TeacherIndex != 'UNKNOWN' -- do not update the UNKNOWN tuple
			THEN
				UPDATE
				SET TT.IsCurrent = 0
			;


--------------------------------------------------------

INSERT INTO Teachers(
	TeacherIndex,
	TName,
	TSurname,
	Title,
	Gender,
	AgeCategory,
	City,
	District,
	IsCurrent
	)
	SELECT
		Tindex,
		TName,
		TSurname,
		Title,
		Gender,
		AgeRange,
		city,
		district,
		1
	FROM vETLTeachers
	EXCEPT
	SELECT
		TeacherIndex,
		TName,
		TSurname,
		Title,
		Gender,
		AgeCategory,
		City,
		District,
		1
	FROM Teachers

		
--------------------------------------------------------


DROP TABLE dbo.TeachersTemp;
Drop View vETLTeachers; 

USE DWSchemaSchool;

SELECT * FROM Teachers
WHERE TeacherIndex = 144351