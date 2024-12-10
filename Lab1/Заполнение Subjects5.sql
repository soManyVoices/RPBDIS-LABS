DECLARE @i INT = 1;
DECLARE @SubjectName NVARCHAR(100);
DECLARE @Description NVARCHAR(255);
DECLARE @EmployeeId INT;

-- ������ ��������� �������� ���������
DECLARE @SubjectNames TABLE (SubjectName NVARCHAR(100));
INSERT INTO @SubjectNames (SubjectName) VALUES
('����������'), ('������'), ('�����'), ('��������'), ('�������'),
('����������'), ('���������'), ('���������� ����'), ('�����������'), ('������');

-- ���������� ������� Subjects ���������� �������
WHILE @i <= 20000  -- 20000 �������
BEGIN
    -- ��������� ����� �������� �������� �� ������
    SELECT TOP 1 @SubjectName = SubjectName FROM @SubjectNames ORDER BY NEWID();
    
    -- ��������� ���������� ��������
    SET @Description = '�������� ��� ' + @SubjectName;

    -- ��������� ����� EmployeeId �� ������������ �����������
    SELECT TOP 1 @EmployeeId = EmployeeId FROM Employees ORDER BY NEWID();

    -- ������� ������ � ������� Subjects
    INSERT INTO Subjects (Name, Description, EmployeeId)
    VALUES (@SubjectName, @Description, @EmployeeId);

    SET @i = @i + 1;
END;
