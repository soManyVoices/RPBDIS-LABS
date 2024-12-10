USE School;

-- Создание временной таблицы для списка имен и фамилий
DECLARE @FirstNames TABLE (FirstName NVARCHAR(50));
DECLARE @LastNames TABLE (LastName NVARCHAR(50));
DECLARE @MiddleNames TABLE (MiddleName NVARCHAR(50));
DECLARE @Genders TABLE (Gender NVARCHAR(10));
DECLARE @ClassIds TABLE (ClassId INT);
DECLARE @Addresses TABLE (Address NVARCHAR(255));

-- Заполнение временных таблиц для имен, фамилий, отчеств, пола, классов и адресов
INSERT INTO @FirstNames (FirstName) VALUES ('Алексей'), ('Мария'), ('Иван'), ('Екатерина'), ('Дмитрий'), ('Анастасия'), ('Сергей'), ('Ольга');
INSERT INTO @LastNames (LastName) VALUES ('Иванов'), ('Петрова'), ('Сидоров'), ('Кузнецова'), ('Михайлов'), ('Смирнова'), ('Васильев'), ('Соколова');
INSERT INTO @MiddleNames (MiddleName) VALUES ('Александрович'), ('Дмитриевна'), ('Иванович'), ('Анатольевна'), ('Викторовна'), ('Геннадьевич'), ('Александровна');
INSERT INTO @Genders (Gender) VALUES ('Мужской'), ('Женский');
-- Заполняем таблицу адресов (примерный список)
INSERT INTO @Addresses (Address) VALUES 
('ул. Пушкина, д. 10, кв. 12'),
('ул. Лермонтова, д. 25, кв. 8'),
('пр. Мира, д. 30, кв. 5'),
('ул. Садовая, д. 15, кв. 2'),
('ул. Толстого, д. 50, кв. 20'),
('пр. Победы, д. 12, кв. 3'),
('ул. Шевченко, д. 22, кв. 11'),
('ул. Чехова, д. 8, кв. 7');

-- Добавим ClassId из существующих классов
INSERT INTO @ClassIds (ClassId)
SELECT ClassId FROM Classes;

-- Заполнение таблицы Students
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

WHILE @i <= 20000  -- Примерное количество записей для студентов
BEGIN
    -- Случайный выбор имени, фамилии, отчества и пола
    SELECT TOP 1 @FirstName = FirstName FROM @FirstNames ORDER BY NEWID();
    SELECT TOP 1 @LastName = LastName FROM @LastNames ORDER BY NEWID();
    SELECT TOP 1 @MiddleName = MiddleName FROM @MiddleNames ORDER BY NEWID();
    SELECT TOP 1 @Gender = Gender FROM @Genders ORDER BY NEWID();
    
    -- Случайная дата рождения в пределах 10-18 лет
    SET @DateOfBirth = DATEADD(YEAR, -FLOOR(RAND() * 8) - 10, GETDATE());  -- Генерация возраста от 10 до 18 лет
    
    -- Случайный выбор ClassId
    SELECT TOP 1 @ClassId = ClassId FROM @ClassIds ORDER BY NEWID();
    
    -- Случайные имена и фамилии родителей
    SELECT TOP 1 @FatherFirstName = FirstName FROM @FirstNames ORDER BY NEWID();
    SELECT TOP 1 @FatherLastName = LastName FROM @LastNames ORDER BY NEWID();
    SELECT TOP 1 @FatherMiddleName = MiddleName FROM @MiddleNames ORDER BY NEWID();
    
    SELECT TOP 1 @MotherFirstName = FirstName FROM @FirstNames ORDER BY NEWID();
    SELECT TOP 1 @MotherLastName = LastName FROM @LastNames ORDER BY NEWID();
    SELECT TOP 1 @MotherMiddleName = MiddleName FROM @MiddleNames ORDER BY NEWID();
    
    -- Случайная дополнительная информация
    SET @AdditionalInfo = 'Дополнительная информация для студента ' + CAST(@i AS NVARCHAR(10));
    
    -- Случайный выбор адреса
    SELECT TOP 1 @Address = Address FROM @Addresses ORDER BY NEWID();

    -- Вставка записи в таблицу Students
    INSERT INTO Students (FirstName, LastName, MiddleName, DateOfBirth, Gender, ClassId, FatherFirstName, FatherLastName, FatherMiddleName, MotherFirstName, MotherLastName, MotherMiddleName, AdditionalInfo, Address)
    VALUES (@FirstName, @LastName, @MiddleName, @DateOfBirth, @Gender, @ClassId, @FatherFirstName, @FatherLastName, @FatherMiddleName, @MotherFirstName, @MotherLastName, @MotherMiddleName, @AdditionalInfo, @Address);

    SET @i = @i + 1;
END;

PRINT 'Данные успешно вставлены в таблицу Students.';
