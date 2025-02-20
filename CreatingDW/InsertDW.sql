USE DWSchemaSchool;
GO


INSERT INTO Teachers VALUES (198604, 'Marek', 'Damaszek', 'Phd', 'Male', '29-34', 'Gdynia', 'Karwiny', 1)
INSERT INTO Teachers VALUES (108960, 'Kaja', 'Kurczak', 'BSc', 'Female', '35-44', 'Gdansk', 'Strzyza', 1)

INSERT INTO Class VALUES ('2A', 'Humanistic', 'Intermediate')
INSERT INTO Class VALUES ('3F', 'Linguistic', 'Beginning')

INSERT INTO Students VALUES (237384, 'Natasza', 'Sznura', '14-15', 'Female', 'Sopot', 'Gorny Sopot', 1)
INSERT INTO Students VALUES (530235, 'Borys', 'Makamaka', '16-17', 'Male', 'Gdansk', 'Suchanino', 0)

INSERT INTO Exam VALUES ('Humanistic', 'Long', 'Morning')
INSERT INTO Exam VALUES ('Linguistic', 'Short', 'Noon')

INSERT INTO Time VALUES (8, 'Morning')
INSERT INTO Time VALUES (3, 'Night')

INSERT INTO Date VALUES ('2015-03-04', 2015, 'March', 3, 4)
INSERT INTO Date VALUES ('2016-01-01', 2016, 'January', 1, 1)

GO
USE DWSchemaSchool;

INSERT INTO Grading VALUES (1, 1, 1, 1, 1, 1, 1, 2.5, 3, 20)
INSERT INTO Grading VALUES (2, 2, 2, 2, 2, 2, 2, 6.0, 5, 50)

SELECT * FROM EXAM
SELECT * FROM Grading

GO