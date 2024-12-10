CREATE PROCEDURE InsertClass
    @Name NVARCHAR(50),
    @ClassTeacher NVARCHAR(100),
    @ClassTypeId INT,
    @StudentCount INT = 0,
    @YearCreated INT
AS
BEGIN
    INSERT INTO Classes (Name, ClassTeacher, ClassTypeId, StudentCount, YearCreated)
    VALUES (@Name, @ClassTeacher, @ClassTypeId, @StudentCount, @YearCreated);
END;
