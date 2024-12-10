USE School;

-- �������� ��������� ������� ��� ������ ���� � �������
DECLARE @FirstNames TABLE (FirstName NVARCHAR(50));
DECLARE @LastNames TABLE (LastName NVARCHAR(50));
DECLARE @MiddleNames TABLE (MiddleName NVARCHAR(50));
DECLARE @Genders TABLE (Gender NVARCHAR(10));
DECLARE @ClassIds TABLE (ClassId INT);
DECLARE @Addresses TABLE (Address NVARCHAR(255));

-- ���������� ��������� ������ ��� ����, �������, �������, ����, ������� � �������
INSERT INTO @FirstNames (FirstName) VALUES ('�������'), ('�����'), ('����'), ('���������'), ('�������'), ('���������'), ('������'), ('�����');
INSERT INTO @LastNames (LastName) VALUES ('������'), ('�������'), ('�������'), ('���������'), ('��������'), ('��������'), ('��������'), ('��������');
INSERT INTO @MiddleNames (MiddleName) VALUES ('�������������'), ('����������'), ('��������'), ('�����������'), ('����������'), ('�����������'), ('�������������');
INSERT INTO @Genders (Gender) VALUES ('�������'), ('�������');
-- ��������� ������� ������� (��������� ������)
INSERT INTO @Addresses (Address) VALUES 
('��. �������, �. 10, ��. 12'),
('��. ����������, �. 25, ��. 8'),
('��. ����, �. 30, ��. 5'),
('��. �������, �. 15, ��. 2'),
('��. ��������, �. 50, ��. 20'),
('��. ������, �. 12, ��. 3'),
('��. ��������, �. 22, ��. 11'),
('��. ������, �. 8, ��. 7');

-- ������� ClassId �� ������������ �������
INSERT INTO @ClassIds (ClassId)
SELECT ClassId FROM Classes;

-- ���������� ������� Students
DECLARE @i INT = 1;
DECLARE @FirstName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);
DECLARE @MiddleName NVARCHAR(50);
DECLARE @DateOfBirth DATE;
DECLARE @Gender NVARCHAR(10);
DECLARE @ClassId INT;
DECLARE @FatherFirstName NVARCHAR(50);
DECLARE @FatherLastName NVARCHAR(50);
DECLARE @FatherMiddleName NVARCHAR(50);
DECLARE @MotherFirstName NVARCHAR(50);
DECLARE @MotherLastName NVARCHAR(50);
DECLARE @MotherMiddleName NVARCHAR(50);
DECLARE @AdditionalInfo NVARCHAR(255);
DECLARE @Address NVARCHAR(255);

WHILE @i <= 20000  -- ��������� ���������� ������� ��� ���������
BEGIN
    -- ��������� ����� �����, �������, �������� � ����
    SELECT TOP 1 @FirstName = FirstName FROM @FirstNames ORDER BY NEWID();
    SELECT TOP 1 @LastName = LastName FROM @LastNames ORDER BY NEWID();
    SELECT TOP 1 @MiddleName = MiddleName FROM @MiddleNames ORDER BY NEWID();
    SELECT TOP 1 @Gender = Gender FROM @Genders ORDER BY NEWID();
    
    -- ��������� ���� �������� � �������� 10-18 ���
    SET @DateOfBirth = DATEADD(YEAR, -FLOOR(RAND() * 8) - 10, GETDATE());  -- ��������� �������� �� 10 �� 18 ���
    
    -- ��������� ����� ClassId
    SELECT TOP 1 @ClassId = ClassId FROM @ClassIds ORDER BY NEWID();
    
    -- ��������� ����� � ������� ���������
    SELECT TOP 1 @FatherFirstName = FirstName FROM @FirstNames ORDER BY NEWID();
    SELECT TOP 1 @FatherLastName = LastName FROM @LastNames ORDER BY NEWID();
    SELECT TOP 1 @FatherMiddleName = MiddleName FROM @MiddleNames ORDER BY NEWID();
    
    SELECT TOP 1 @MotherFirstName = FirstName FROM @FirstNames ORDER BY NEWID();
    SELECT TOP 1 @MotherLastName = LastName FROM @LastNames ORDER BY NEWID();
    SELECT TOP 1 @MotherMiddleName = MiddleName FROM @MiddleNames ORDER BY NEWID();
    
    -- ��������� �������������� ����������
    SET @AdditionalInfo = '�������������� ���������� ��� �������� ' + CAST(@i AS NVARCHAR(10));
    
    -- ��������� ����� ������
    SELECT TOP 1 @Address = Address FROM @Addresses ORDER BY NEWID();

    -- ������� ������ � ������� Students
    INSERT INTO Students (FirstName, LastName, MiddleName, DateOfBirth, Gender, ClassId, FatherFirstName, FatherLastName, FatherMiddleName, MotherFirstName, MotherLastName, MotherMiddleName, AdditionalInfo, Address)
    VALUES (@FirstName, @LastName, @MiddleName, @DateOfBirth, @Gender, @ClassId, @FatherFirstName, @FatherLastName, @FatherMiddleName, @MotherFirstName, @MotherLastName, @MotherMiddleName, @AdditionalInfo, @Address);

    SET @i = @i + 1;
END;

PRINT '������ ������� ��������� � ������� Students.';
