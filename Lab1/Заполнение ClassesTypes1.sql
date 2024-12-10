use School

-- Вставка данных в таблицу ClassTypes
DECLARE @i INT = 1;
DECLARE @ClassTypeName NVARCHAR(100);
DECLARE @Description NVARCHAR(255);

WHILE @i <= 500
BEGIN
    -- Сгенерируем случайное название типа класса (например, "Тип 1", "Тип 2" и т.д.)
    SET @ClassTypeName = CONCAT('Тип класса ', @i);

    -- Сгенерируем описание, которое будет различаться для каждого типа
    SET @Description = CONCAT('Описание для типа класса ', @i);

    -- Вставка записи в таблицу
    INSERT INTO ClassTypes (Name, Description)
    VALUES (@ClassTypeName, @Description);

    SET @i = @i + 1;
END;
