CREATE PROCEDURE UpdateStudent
    @StudentId INT,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @MiddleName NVARCHAR(50) = NULL,
    @DateOfBirth DATE = NULL,
    @Gender NVARCHAR(10) = NULL,
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
    UPDATE Students
    SET 
        FirstName = ISNULL(@FirstName, FirstName),
        LastName = ISNULL(@LastName, LastName),
        MiddleName = ISNULL(@MiddleName, MiddleName),
        DateOfBirth = ISNULL(@DateOfBirth, DateOfBirth),
        Gender = ISNULL(@Gender, Gender),
        Address = ISNULL(@Address, Address),
        FatherFirstName = ISNULL(@FatherFirstName, FatherFirstName),
        FatherLastName = ISNULL(@FatherLastName, FatherLastName),
        FatherMiddleName = ISNULL(@FatherMiddleName, FatherMiddleName),
        MotherFirstName = ISNULL(@MotherFirstName, MotherFirstName),
        MotherLastName = ISNULL(@MotherLastName, MotherLastName),
        MotherMiddleName = ISNULL(@MotherMiddleName, MotherMiddleName),
        ClassId = ISNULL(@ClassId, ClassId),
        AdditionalInfo = ISNULL(@AdditionalInfo, AdditionalInfo)
    WHERE StudentId = @StudentId;
END;
