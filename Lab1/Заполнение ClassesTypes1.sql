use School

-- ������� ������ � ������� ClassTypes
DECLARE @i INT = 1;
DECLARE @ClassTypeName NVARCHAR(100);
DECLARE @Description NVARCHAR(255);

WHILE @i <= 500
BEGIN
    -- ����������� ��������� �������� ���� ������ (��������, "��� 1", "��� 2" � �.�.)
    SET @ClassTypeName = CONCAT('��� ������ ', @i);

    -- ����������� ��������, ������� ����� ����������� ��� ������� ����
    SET @Description = CONCAT('�������� ��� ���� ������ ', @i);

    -- ������� ������ � �������
    INSERT INTO ClassTypes (Name, Description)
    VALUES (@ClassTypeName, @Description);

    SET @i = @i + 1;
END;
