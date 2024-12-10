USE School;

-- Создание временных таблиц для дней недели, времени начала и окончания
DECLARE @DaysOfWeek TABLE (DayOfWeek NVARCHAR(20));
DECLARE @StartTimes TABLE (StartTime TIME);
DECLARE @EndTimes TABLE (EndTime TIME);

-- Заполнение временных таблиц
INSERT INTO @DaysOfWeek (DayOfWeek)
VALUES ('Понедельник'), ('Вторник'), ('Среда'), ('Четверг'), ('Пятница'), ('Суббота'), ('Воскресенье');

INSERT INTO @StartTimes (StartTime)
VALUES ('08:00'), ('09:00'), ('10:00'), ('11:00'), ('12:00'), ('13:00'), ('14:00'), ('15:00'), ('16:00'), ('17:00');

-- Корректное задание времен окончания, чтобы они всегда были позже времени начала
INSERT INTO @EndTimes (EndTime)
VALUES ('09:00'), ('10:00'), ('11:00'), ('12:00'), ('13:00'), ('14:00'), ('15:00'), ('16:00'), ('17:00'), ('18:00');

-- Заполнение таблицы Schedule
DECLARE @i INT = 1;
DECLARE @ClassId INT;
DECLARE @SubjectId INT;
DECLARE @DayOfWeek NVARCHAR(20);
DECLARE @StartTime TIME;
DECLARE @EndTime TIME;
DECLARE @Date DATE;

WHILE @i <= 20000  -- Примерное количество записей для расписания
BEGIN
    -- Случайный выбор ID класса и предмета
    SELECT TOP 1 @ClassId = ClassId FROM Classes ORDER BY NEWID();
    SELECT TOP 1 @SubjectId = SubjectId FROM Subjects ORDER BY NEWID();
    
    -- Случайный выбор дня недели
    SELECT TOP 1 @DayOfWeek = DayOfWeek FROM @DaysOfWeek ORDER BY NEWID();
    
    -- Случайный выбор времени начала
    SELECT TOP 1 @StartTime = StartTime FROM @StartTimes ORDER BY NEWID();

    -- Выбираем время окончания, которое будет больше времени начала
    -- Ищем первый конец, который больше выбранного начала
    SELECT TOP 1 @EndTime = EndTime
    FROM @EndTimes
    WHERE EndTime > @StartTime
    ORDER BY NEWID();
    
    -- Случайная дата в текущем месяце (например, декабрь 2024 года)
    SET @Date = DATEADD(DAY, FLOOR(RAND() * 31), '2024-12-01');
    
    -- Вставка записи в таблицу Schedule
    INSERT INTO Schedule (Date, DayOfWeek, ClassId, SubjectId, StartTime, EndTime)
    VALUES (@Date, @DayOfWeek, @ClassId, @SubjectId, @StartTime, @EndTime);

    SET @i = @i + 1;
END;
