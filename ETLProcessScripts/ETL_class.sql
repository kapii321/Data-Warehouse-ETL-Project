USE DWSchemaSchool
GO

If (object_id('vETLClass') is not null) Drop View vETLClass;
go
CREATE VIEW vETLClass
AS
SELECT DISTINCT
	[Class_Name] as [Name],
	[Specialization],
	[Level]
FROM [SchoolSystem].dbo.[Class]
;
go

MERGE INTO Class as TT
	USING vETLClass as ST
		ON TT.Name = ST.Name
		AND TT.Specialization = ST.Specialization
		AND TT.Level = ST.Level
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.Name,
					ST.Specialization,
					ST.Level
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

USE DWSchemaSchool
GO

SELECT * FROM Teachers
Drop View vETLClass;

SELECT * FROM Class
