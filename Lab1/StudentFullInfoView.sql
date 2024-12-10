USE School;
GO

CREATE VIEW StuentsFullInfo AS
SELECT 
    c.ClassId,
    c.Name AS ClassName,                   -- Имя класса
    c.ClassTeacher,
    ct.Name AS ClassType,                  -- Тип класса
    c.StudentCount,
    c.YearCreated,
    st.StudentId,
    st.FirstName AS StudentFirstName,      -- Имя ученика
    st.LastName AS StudentLastName,        -- Фамилия ученика
    st.MiddleName AS StudentMiddleName,    -- Отчество ученика
    st.DateOfBirth,
    st.Gender,
    st.Address,
    st.FatherFirstName + ' ' + st.FatherLastName AS FatherName, -- Имя отца
    st.MotherFirstName + ' ' + st.MotherLastName AS MotherName, -- Имя матери
    st.AdditionalInfo                      -- Дополнительная информация об ученике
FROM 
    Classes c
JOIN 
    ClassTypes ct ON c.ClassTypeId = ct.ClassTypeId
LEFT JOIN 
    Students st ON c.ClassId = st.ClassId; 
