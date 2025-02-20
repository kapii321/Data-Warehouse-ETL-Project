USE SchoolSystem;
GO

CREATE TABLE Classrooms (
	Room_number INT PRIMARY KEY,
	School_floor INT  NOT NULL,
	Building VARCHAR(25) NOT NULL,
	Size INT NOT NULL
);

CREATE TABLE Class (
	Class_Name VARCHAR(2) PRIMARY KEY,
	Specialization VARCHAR(25) NOT NULL,
	Level VARCHAR(25) NOT NULL
);

CREATE TABLE Students (
	StudentID VARCHAR(6) PRIMARY KEY,
	SName VARCHAR(30) NOT NULL,
	SSurname VARCHAR(30) NOT NULL,
	Class_Name VARCHAR(2) NOT NULL,

	FOREIGN KEY (Class_Name)
    REFERENCES Class (Class_Name),
);

CREATE TABLE Teachers (
	TeacherID VARCHAR(6) PRIMARY KEY,
	TName VARCHAR(30) NOT NULL,
	TSurname VARCHAR(30) NOT NULL
);

CREATE TABLE DiagnosticExams (
	ExamID INT PRIMARY KEY,
	ExamType VARCHAR(1) NOT NULL,
	ExamDate DATETIME NOT NULL,
	Duration INT NOT NULL,
	TeacherID VARCHAR(6) NOT NULL,
	Room_number INT NOT NULL,

	FOREIGN KEY (TeacherID)
    REFERENCES Teachers (TeacherID),

	FOREIGN KEY (Room_number)
    REFERENCES Classrooms (Room_number)
);


CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    GradeValue FLOAT NOT NULL,
    GradeDate DATETIME NOT NULL,
	Plagiarism BIT NOT NULL,
    StudentID VARCHAR(6) NOT NULL,
    ExamID INT NOT NULL,
    TeacherID VARCHAR(6) NOT NULL,
	Satisfaction INT NOT NULL,
	WritingTime INT NOT NULL,

    FOREIGN KEY (StudentID)
    REFERENCES Students (StudentID),

    FOREIGN KEY (ExamID)
    REFERENCES DiagnosticExams (ExamID),

    FOREIGN KEY (TeacherID)
    REFERENCES Teachers (TeacherID)
);


CREATE TABLE Is_Teaching (
	Class_Name VARCHAR(2) NOT NULL,
	TeacherID VARCHAR(6) NOT NULL,
	PRIMARY KEY (Class_Name, TeacherID),

	FOREIGN KEY (TeacherID)
	REFERENCES Teachers (TeacherID),

	FOREIGN KEY (Class_Name)
	REFERENCES Class (Class_Name),
)