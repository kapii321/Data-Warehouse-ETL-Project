use DWSchemaSchool;
go




If (object_id('vETLGrading') is not null) Drop view vETLGrading;
go
CREATE VIEW vETLGrading
AS
SELECT 
	x.Grade
	, x.Satisfaction
	, x.WritingTime
	, x.StudentKey
	, x.TeacherKey
	, x.SupervisorKey
	, x.ClassKey
	, x.ExamKey
	, x.TimeKey
	, x.DateKey
FROM
	(SELECT 
		  Grade = GD.GradeValue
		, Satisfaction = GD.Satisfaction 
		, WritingTime = GD.WritingTime
		, StudentKey = STU.StudentID
		, TeacherKey = TEA1.TeacherID
		, SupervisorKey = SUP.TeacherID
		, ClassKey = CLA.ClassID
		, ExamKey = EXA.ExamID
		, TimeKey = T.TimeID 
		, DateKey = D.DateID

	FROM SchoolSystem.dbo.Grades AS GD
	JOIN DWSchemaSchool.dbo.Students as STU ON GD.StudentID = STU.StudentIndex AND STU.IsCurrent =1
	JOIN DWSchemaSchool.dbo.Teachers as TEA1 ON GD.TeacherID = TEA1.TeacherIndex AND TEA1.IsCurrent =1
	JOIN SchoolSystem.dbo.DiagnosticExams as SourceEXA ON GD.ExamID = SourceEXA.ExamID
	JOIN DWSchemaSchool.dbo.MapExamTemp as ExamMap ON SourceEXA.ExamID = ExamMap.BK
	JOIN DWSchemaSchool.dbo.Exam AS EXA ON EXA.ExamID = ExamMap.DW_ID
	JOIN DWSchemaSchool.dbo.Teachers as SUP ON SUP.TeacherIndex= SourceEXA.TeacherID AND SUP.IsCurrent =1
	JOIN SchoolSystem.dbo.Students as SourceSTU ON SourceSTU.StudentID = STU.StudentIndex AND STU.IsCurrent =1
	JOIN DWSchemaSchool.dbo.Class as CLA ON CLA.Name = SourceSTU.Class_Name

	JOIN dbo.Date as D ON CONVERT(VARCHAR(10), D.Date, 111) = CONVERT(VARCHAR(10), GD.GradeDate, 111)
	JOIN dbo.Time as T ON T.Hour = DATEPART(HOUR, GD.GradeDate)
	) as x
go



MERGE INTO Grading as TT
USING vETLGrading as ST
ON 
TT.ExamID = ST.ExamKey
AND TT.StudentID = ST.StudentKey
AND TT.TeacherID = ST.TeacherKey
AND TT.SupervisorID = ST.SupervisorKey
AND TT.TimeID = ST.TimeKey
AND TT.DateID = ST.DateKey
AND TT.ClassID = ST.ClassKey
WHEN Not Matched
THEN
INSERT
Values (
 ST.ExamKey
,ST.StudentKey
, ST.TeacherKey
, ST.SupervisorKey
, ST.TimeKey
, ST.DateKey
, ST.ClassKey
, ST.Grade
, ST.Satisfaction
, ST.WritingTime
)
;
SELECT * FROM vETLGrading;

Drop view vETLGrading;
DROP TABLE MapExamTemp;

SELECT * FROM Grading





--SELECT * FROM DWSchemaSchool.dbo.Grading

--SELECT * FROM Students

--SELECT * FROM SchoolSystem.dbo.Grades

-- select * from FBookSales;
SELECT * FROM Grading
JOIN Students ON Grading.StudentID = Students.StudentID
JOIN Teachers ON Grading.TeacherID = Teachers.TeacherID
WHERE Students.IsCurrent =0 OR
	Teachers.IsCurrent =0

SELECT * FROM GRADING
JOIN Students ON Grading.StudentID = Students.StudentID
JOIN Teachers ON Grading.TeacherID = Teachers.TeacherID
WHERE Students.StudentIndex = 559455 
AND Teachers.TeacherIndex = 187184