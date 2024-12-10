USE School;

-- Создание временных таблиц для имен, фамилий, отчеств
CREATE TABLE #MaleNames (Name NVARCHAR(50));
CREATE TABLE #FemaleNames (Name NVARCHAR(50));
CREATE TABLE #LastNames (LastName NVARCHAR(50));
CREATE TABLE #FemaleLastNames (FemaleLastName NVARCHAR(50));
CREATE TABLE #MalePatronymics (Patronymic NVARCHAR(50));
CREATE TABLE #FemalePatronymics (Patronymic NVARCHAR(50));

-- Заполнение временных таблиц
INSERT INTO #MaleNames (Name) VALUES
('Александр'), ('Максим'), ('Дмитрий'), ('Иван'), ('Анатолий'), 
('Евгений'), ('Павел'), ('Артем'), ('Сергей'), ('Роман');

INSERT INTO #FemaleNames (Name) VALUES
('Анна'), ('Екатерина'), ('Мария'), ('Ольга'), ('Светлана'), 
('Наталья'), ('Дарья'), ('Елена'), ('Татьяна'), ('Юлия');

INSERT INTO #LastNames (LastName) VALUES
('Иванов'), ('Петров'), ('Сидоров'), ('Кузнецов'), ('Семёнов'), 
('Фёдоров'), ('Морозов'), ('Попов'), ('Васильев'), ('Зайцев');

INSERT INTO #FemaleLastNames (FemaleLastName) VALUES
('Иванова'), ('Петрова'), ('Сидорова'), ('Кузнецова'), ('Семёнова'), 
('Фёдорова'), ('Морозова'), ('Попова'), ('Васильева'), ('Зайцева');

INSERT INTO #MalePatronymics (Patronymic) VALUES
('Александрович'), ('Максимович'), ('Дмитриевич'), ('Иванович'), 
('Анатольевич'), ('Евгеньевич'), ('Павлович'), ('Артёмович'), 
('Сергеевич'), ('Романович');

INSERT INTO #FemalePatronymics (Patronymic) VALUES
('Александровна'), ('Максимовна'), ('Дмитриевна'), ('Ивановна'), 
('Анатольевна'), ('Евгеньевна'), ('Павловна'), ('Артёмовна'), 
('Сергеевна'), ('Романовна');

-- Заполнение таблицы Employees с разнообразными именами, фамилиями и позициями
DECLARE @i INT = 1;
DECLARE @MaleName NVARCHAR(50);
DECLARE @FemaleName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);
DECLARE @FemaleLastName NVARCHAR(50);
DECLARE @MalePatronymic NVARCHAR(50);
DECLARE @FemalePatronymic NVARCHAR(50);
DECLARE @PositionId INT;

WHILE @i <= 500  -- 500 сотрудников
BEGIN
    -- Случайный выбор ID должности из существующей таблицы Positions
    SELECT TOP 1 @PositionId = PositionId FROM Positions ORDER BY NEWID();

    IF @i % 2 = 0
    BEGIN
        -- Женский сотрудник
        SELECT TOP 1 @FemaleName = Name FROM #FemaleNames ORDER BY NEWID();
        SELECT TOP 1 @FemaleLastName = FemaleLastName FROM #FemaleLastNames ORDER BY NEWID();
        SELECT TOP 1 @FemalePatronymic = Patronymic FROM #FemalePatronymics ORDER BY NEWID();

        INSERT INTO Employees (FirstName, LastName, MiddleName, PositionId)
        VALUES (
            @FemaleName, 
            @FemaleLastName, 
            @FemalePatronymic, 
            @PositionId  -- Случайная должность по ID
        );
    END
    ELSE
    BEGIN
        -- Мужской сотрудник
        SELECT TOP 1 @MaleName = Name FROM #MaleNames ORDER BY NEWID();
        SELECT TOP 1 @LastName = LastName FROM #LastNames ORDER BY NEWID();
        SELECT TOP 1 @MalePatronymic = Patronymic FROM #MalePatronymics ORDER BY NEWID();

        INSERT INTO Employees (FirstName, LastName, MiddleName, PositionId)
        VALUES (
            @MaleName, 
            @LastName, 
            @MalePatronymic, 
            @PositionId  -- Случайная должность по ID
        );
    END;
    SET @i = @i + 1;
END;

-- Удаление временных таблиц
DROP TABLE #MaleNames;
DROP TABLE #FemaleNames;
DROP TABLE #LastNames;
DROP TABLE #FemaleLastNames;
DROP TABLE #MalePatronymics;
DROP TABLE #FemalePatronymics;
