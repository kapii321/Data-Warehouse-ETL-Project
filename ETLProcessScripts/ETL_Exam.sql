USE DWSchemaSchool
GO

If (object_id('vETLExam') is not null) Drop View vETLExam;
go

CREATE VIEW vETLExam
AS
SELECT 
	t1.[ExamID] as [EIndex],
	CASE
		WHEN t1.[ExamType] = 'H' THEN 'Humanistic'
		WHEN t1.ExamType = 'L' THEN 'Linguistic'
		ELSE 'Scientific'
	END AS [type],
	CASE
		WHEN t1.[Duration] BETWEEN 59 AND 80 THEN 'Short'
		WHEN t1.[Duration] BETWEEN 81 AND 100 THEN 'Medium'
		ELSE 'Long'
	END AS [DurationCat],
	CASE
		WHEN DATEPART(HOUR,[ExamDate]) BETWEEN 6 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR,[ExamDate]) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(HOUR,[ExamDate]) BETWEEN 18 AND 23 THEN 'Evening'
		WHEN DATEPART(HOUR,[ExamDate]) BETWEEN 0 AND 5 THEN 'Night'
	END AS [TimeCat]
FROM SchoolSystem.dbo.DiagnosticExams as t1
;
go

If (object_id('MapExamTemp') is not null) Drop TABLE MapExamTemp;
CREATE TABLE dbo.MapExamTemp(DW_ID INT IDENTITY(1,1) PRIMARY KEY,
	Type VARCHAR(15) NOT NULL,
	DurationCategory VARCHAR(10) NOT NULL,
	ExamTimeCategory VARCHAR(10) NOT NULL,
	BK INT);
go







MERGE INTO DWSchemaSchool.dbo.MapExamTemp as TT
	USING vETLExam as ST
		ON TT.BK = ST.EIndex
			WHEN Not Matched
				THEN
					INSERT Values (
					ST.type,
					ST.DurationCat,
					ST.TimeCat,
					ST.EIndex
					)
			WHEN Not Matched BY Source
			THEN
				DELETE
			;


MERGE INTO DWSchemaSchool.dbo.Exam as TT
	USING MapExamTemp as ST
		ON TT.ExamID = ST.DW_ID
			WHEN Not Matched
				THEN
					INSERT Values (
					ST.Type,
					ST.DurationCategory,
					ST.ExamTimeCategory
					)
			WHEN Not Matched BY Source
			THEN
				DELETE
			;




Drop View vETLExam 

SELECT * FROM MapExamTemp
SELECT * FROM Exam
SELECT * FROM SchoolSystem.dbo.DiagnosticExams

