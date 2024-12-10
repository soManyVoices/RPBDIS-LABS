-- �������� ���� ������
CREATE DATABASE School;
GO

USE School;
GO

-- �������� ������� ����� �������
CREATE TABLE ClassTypes (
    ClassTypeId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(255)
);

-- �������� ������� �������
CREATE TABLE Classes (
    ClassId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE,
    ClassTeacher NVARCHAR(100) NOT NULL,
    ClassTypeId INT NOT NULL,
    StudentCount INT CHECK (StudentCount >= 0),
    YearCreated INT NOT NULL,
    CONSTRAINT FK_Classes_ClassTypes FOREIGN KEY (ClassTypeId) REFERENCES ClassTypes(ClassTypeId) ON DELETE CASCADE
);

-- �������� ������� ����������
CREATE TABLE Positions (
    PositionId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE, -- �������� ���������, �������� "�������", "�������������"
    Description NVARCHAR(255),          -- �������� ���������
    Salary DECIMAL(10, 2)              -- ���������� ����� (���� �����)
);

-- �������� ������� �����������
CREATE TABLE Employees (
    EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50),
    PositionId INT NOT NULL, -- ������� ���� �� ��������� ����������
    CONSTRAINT FK_Employees_Positions FOREIGN KEY (PositionId) REFERENCES Positions(PositionId)
);

-- �������� ������� ���������
CREATE TABLE Subjects (
    SubjectId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(255),
    EmployeeId INT NOT NULL,
    CONSTRAINT FK_Subjects_Employees FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId) ON DELETE CASCADE
);

-- �������� ������� ��������
CREATE TABLE Students (
    StudentId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50),
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(10) CHECK (Gender IN ('�������', '�������')) NOT NULL,
    Address NVARCHAR(255),
    FatherFirstName NVARCHAR(50),
    FatherLastName NVARCHAR(50),
    FatherMiddleName NVARCHAR(50),
    MotherFirstName NVARCHAR(50),
    MotherLastName NVARCHAR(50),
    MotherMiddleName NVARCHAR(50),
    ClassId INT,
    AdditionalInfo NVARCHAR(255),
    CONSTRAINT FK_Students_Classes FOREIGN KEY (ClassId) REFERENCES Classes(ClassId) ON DELETE SET NULL
);

-- �������� ������� ����������
CREATE TABLE Schedule (
    ScheduleId INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE NOT NULL,
    DayOfWeek NVARCHAR(20) CHECK (DayOfWeek IN ('�����������', '�������', '�����', '�������', '�������', '�������', '�����������')) NOT NULL,
    ClassId INT NOT NULL,
    SubjectId INT NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    CONSTRAINT FK_Schedule_Classes FOREIGN KEY (ClassId) REFERENCES Classes(ClassId) ON DELETE CASCADE,
    CONSTRAINT FK_Schedule_Subjects FOREIGN KEY (SubjectId) REFERENCES Subjects(SubjectId) ON DELETE CASCADE,
    CONSTRAINT CHK_Schedule_Time CHECK (StartTime < EndTime)
);

-- �������� �������������� �������� ��� ��������� ��������
CREATE INDEX idx_Students_ClassId ON Students(ClassId);
CREATE INDEX idx_Schedule_ClassId ON Schedule(ClassId);
CREATE INDEX idx_Schedule_SubjectId ON Schedule(SubjectId);
CREATE INDEX idx_Classes_ClassTypeId ON Classes(ClassTypeId);
