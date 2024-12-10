USE School;

-- �������� ��������� ������ ��� ����, �������, �������
CREATE TABLE #MaleNames (Name NVARCHAR(50));
CREATE TABLE #FemaleNames (Name NVARCHAR(50));
CREATE TABLE #LastNames (LastName NVARCHAR(50));
CREATE TABLE #FemaleLastNames (FemaleLastName NVARCHAR(50));
CREATE TABLE #MalePatronymics (Patronymic NVARCHAR(50));
CREATE TABLE #FemalePatronymics (Patronymic NVARCHAR(50));

-- ���������� ��������� ������
INSERT INTO #MaleNames (Name) VALUES
('���������'), ('������'), ('�������'), ('����'), ('��������'), 
('�������'), ('�����'), ('�����'), ('������'), ('�����');

INSERT INTO #FemaleNames (Name) VALUES
('����'), ('���������'), ('�����'), ('�����'), ('��������'), 
('�������'), ('�����'), ('�����'), ('�������'), ('����');

INSERT INTO #LastNames (LastName) VALUES
('������'), ('������'), ('�������'), ('��������'), ('������'), 
('Ը�����'), ('�������'), ('�����'), ('��������'), ('������');

INSERT INTO #FemaleLastNames (FemaleLastName) VALUES
('�������'), ('�������'), ('��������'), ('���������'), ('�������'), 
('Ը������'), ('��������'), ('������'), ('���������'), ('�������');

INSERT INTO #MalePatronymics (Patronymic) VALUES
('�������������'), ('����������'), ('����������'), ('��������'), 
('�����������'), ('����������'), ('��������'), ('��������'), 
('���������'), ('���������');

INSERT INTO #FemalePatronymics (Patronymic) VALUES
('�������������'), ('����������'), ('����������'), ('��������'), 
('�����������'), ('����������'), ('��������'), ('��������'), 
('���������'), ('���������');

-- ���������� ������� Employees � �������������� �������, ��������� � ���������
DECLARE @i INT = 1;
DECLARE @MaleName NVARCHAR(50);
DECLARE @FemaleName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);
DECLARE @FemaleLastName NVARCHAR(50);
DECLARE @MalePatronymic NVARCHAR(50);
DECLARE @FemalePatronymic NVARCHAR(50);
DECLARE @PositionId INT;

WHILE @i <= 500  -- 500 �����������
BEGIN
    -- ��������� ����� ID ��������� �� ������������ ������� Positions
    SELECT TOP 1 @PositionId = PositionId FROM Positions ORDER BY NEWID();

    IF @i % 2 = 0
    BEGIN
        -- ������� ���������
        SELECT TOP 1 @FemaleName = Name FROM #FemaleNames ORDER BY NEWID();
        SELECT TOP 1 @FemaleLastName = FemaleLastName FROM #FemaleLastNames ORDER BY NEWID();
        SELECT TOP 1 @FemalePatronymic = Patronymic FROM #FemalePatronymics ORDER BY NEWID();

        INSERT INTO Employees (FirstName, LastName, MiddleName, PositionId)
        VALUES (
            @FemaleName, 
            @FemaleLastName, 
            @FemalePatronymic, 
            @PositionId  -- ��������� ��������� �� ID
        );
    END
    ELSE
    BEGIN
        -- ������� ���������
        SELECT TOP 1 @MaleName = Name FROM #MaleNames ORDER BY NEWID();
        SELECT TOP 1 @LastName = LastName FROM #LastNames ORDER BY NEWID();
        SELECT TOP 1 @MalePatronymic = Patronymic FROM #MalePatronymics ORDER BY NEWID();

        INSERT INTO Employees (FirstName, LastName, MiddleName, PositionId)
        VALUES (
            @MaleName, 
            @LastName, 
            @MalePatronymic, 
            @PositionId  -- ��������� ��������� �� ID
        );
    END;
    SET @i = @i + 1;
END;

-- �������� ��������� ������
DROP TABLE #MaleNames;
DROP TABLE #FemaleNames;
DROP TABLE #LastNames;
DROP TABLE #FemaleLastNames;
DROP TABLE #MalePatronymics;
DROP TABLE #FemalePatronymics;
