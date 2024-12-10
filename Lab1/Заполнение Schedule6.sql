USE School;

-- �������� ��������� ������ ��� ���� ������, ������� ������ � ���������
DECLARE @DaysOfWeek TABLE (DayOfWeek NVARCHAR(20));
DECLARE @StartTimes TABLE (StartTime TIME);
DECLARE @EndTimes TABLE (EndTime TIME);

-- ���������� ��������� ������
INSERT INTO @DaysOfWeek (DayOfWeek)
VALUES ('�����������'), ('�������'), ('�����'), ('�������'), ('�������'), ('�������'), ('�����������');

INSERT INTO @StartTimes (StartTime)
VALUES ('08:00'), ('09:00'), ('10:00'), ('11:00'), ('12:00'), ('13:00'), ('14:00'), ('15:00'), ('16:00'), ('17:00');

-- ���������� ������� ������ ���������, ����� ��� ������ ���� ����� ������� ������
INSERT INTO @EndTimes (EndTime)
VALUES ('09:00'), ('10:00'), ('11:00'), ('12:00'), ('13:00'), ('14:00'), ('15:00'), ('16:00'), ('17:00'), ('18:00');

-- ���������� ������� Schedule
DECLARE @i INT = 1;
DECLARE @ClassId INT;
DECLARE @SubjectId INT;
DECLARE @DayOfWeek NVARCHAR(20);
DECLARE @StartTime TIME;
DECLARE @EndTime TIME;
DECLARE @Date DATE;

WHILE @i <= 20000  -- ��������� ���������� ������� ��� ����������
BEGIN
    -- ��������� ����� ID ������ � ��������
    SELECT TOP 1 @ClassId = ClassId FROM Classes ORDER BY NEWID();
    SELECT TOP 1 @SubjectId = SubjectId FROM Subjects ORDER BY NEWID();
    
    -- ��������� ����� ��� ������
    SELECT TOP 1 @DayOfWeek = DayOfWeek FROM @DaysOfWeek ORDER BY NEWID();
    
    -- ��������� ����� ������� ������
    SELECT TOP 1 @StartTime = StartTime FROM @StartTimes ORDER BY NEWID();

    -- �������� ����� ���������, ������� ����� ������ ������� ������
    -- ���� ������ �����, ������� ������ ���������� ������
    SELECT TOP 1 @EndTime = EndTime
    FROM @EndTimes
    WHERE EndTime > @StartTime
    ORDER BY NEWID();
    
    -- ��������� ���� � ������� ������ (��������, ������� 2024 ����)
    SET @Date = DATEADD(DAY, FLOOR(RAND() * 31), '2024-12-01');
    
    -- ������� ������ � ������� Schedule
    INSERT INTO Schedule (Date, DayOfWeek, ClassId, SubjectId, StartTime, EndTime)
    VALUES (@Date, @DayOfWeek, @ClassId, @SubjectId, @StartTime, @EndTime);

    SET @i = @i + 1;
END;
