use School

-- Заполнение таблицы Classes
DECLARE @ClassId INT = 1;
WHILE @ClassId <= 500
BEGIN
    INSERT INTO Classes (Name, ClassTeacher, ClassTypeId, StudentCount, YearCreated)
    VALUES ('Класс ' + CAST(@ClassId AS NVARCHAR(50)), 'Учитель ' + CAST(@ClassId AS NVARCHAR(100)), 
            (SELECT TOP 1 ClassTypeId FROM ClassTypes ORDER BY NEWID()), 
            (RAND() * 30) + 10, 2024);
    SET @ClassId = @ClassId + 1;
END;