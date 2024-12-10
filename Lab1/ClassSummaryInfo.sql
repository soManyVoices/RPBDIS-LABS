CREATE VIEW ClassSummaryInfo AS
SELECT 
    c.ClassId,
    c.Name AS ClassName,
    c.ClassTeacher,
    ct.Name AS ClassType,
    c.StudentCount,
    c.YearCreated
FROM 
    Classes c
JOIN 
    ClassTypes ct ON c.ClassTypeId = ct.ClassTypeId;
