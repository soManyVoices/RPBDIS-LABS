DECLARE @i INT = 1;
DECLARE @SubjectName NVARCHAR(100);
DECLARE @Description NVARCHAR(255);
DECLARE @EmployeeId INT;

-- Список возможных названий предметов
DECLARE @SubjectNames TABLE (SubjectName NVARCHAR(100));
INSERT INTO @SubjectNames (SubjectName) VALUES
('Математика'), ('Физика'), ('Химия'), ('Биология'), ('История'),
('Литература'), ('География'), ('Английский язык'), ('Физкультура'), ('Музыка');

-- Заполнение таблицы Subjects случайными данными
WHILE @i <= 20000  -- 20000 записей
BEGIN
    -- Случайный выбор названия предмета из списка
    SELECT TOP 1 @SubjectName = SubjectName FROM @SubjectNames ORDER BY NEWID();
    
    -- Генерация случайного описания
    SET @Description = 'Описание для ' + @SubjectName;

    -- Случайный выбор EmployeeId из существующих сотрудников
    SELECT TOP 1 @EmployeeId = EmployeeId FROM Employees ORDER BY NEWID();

    -- Вставка данных в таблицу Subjects
    INSERT INTO Subjects (Name, Description, EmployeeId)
    VALUES (@SubjectName, @Description, @EmployeeId);

    SET @i = @i + 1;
END;
