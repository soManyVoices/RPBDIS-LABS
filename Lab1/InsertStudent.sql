CREATE PROCEDURE InsertStudent
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @MiddleName NVARCHAR(50) = NULL,
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @Address NVARCHAR(255) = NULL,
    @FatherFirstName NVARCHAR(50) = NULL,
    @FatherLastName NVARCHAR(50) = NULL,
    @FatherMiddleName NVARCHAR(50) = NULL,
    @MotherFirstName NVARCHAR(50) = NULL,
    @MotherLastName NVARCHAR(50) = NULL,
    @MotherMiddleName NVARCHAR(50) = NULL,
    @ClassId INT = NULL,
    @AdditionalInfo NVARCHAR(255) = NULL
AS
BEGIN
    INSERT INTO Students (
        FirstName, LastName, MiddleName, DateOfBirth, Gender, Address, 
        FatherFirstName, FatherLastName, FatherMiddleName, 
        MotherFirstName, MotherLastName, MotherMiddleName, 
        ClassId, AdditionalInfo
    )
    VALUES (
        @FirstName, @LastName, @MiddleName, @DateOfBirth, @Gender, @Address, 
        @FatherFirstName, @FatherLastName, @FatherMiddleName, 
        @MotherFirstName, @MotherLastName, @MotherMiddleName, 
        @ClassId, @AdditionalInfo
    );
END;
