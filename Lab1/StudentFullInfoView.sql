USE School;
GO

CREATE VIEW StuentsFullInfo AS
SELECT 
    c.ClassId,
    c.Name AS ClassName,                   -- ��� ������
    c.ClassTeacher,
    ct.Name AS ClassType,                  -- ��� ������
    c.StudentCount,
    c.YearCreated,
    st.StudentId,
    st.FirstName AS StudentFirstName,      -- ��� �������
    st.LastName AS StudentLastName,        -- ������� �������
    st.MiddleName AS StudentMiddleName,    -- �������� �������
    st.DateOfBirth,
    st.Gender,
    st.Address,
    st.FatherFirstName + ' ' + st.FatherLastName AS FatherName, -- ��� ����
    st.MotherFirstName + ' ' + st.MotherLastName AS MotherName, -- ��� ������
    st.AdditionalInfo                      -- �������������� ���������� �� �������
FROM 
    Classes c
JOIN 
    ClassTypes ct ON c.ClassTypeId = ct.ClassTypeId
LEFT JOIN 
    Students st ON c.ClassId = st.ClassId; 
