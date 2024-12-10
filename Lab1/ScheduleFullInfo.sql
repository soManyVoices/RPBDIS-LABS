USE School
GO
CREATE VIEW ScheduleFullInfo AS
SELECT 
    s.ScheduleId,
    s.Date,
    s.DayOfWeek,
    s.StartTime,
    s.EndTime,
    cl.Name AS ClassName,
    sub.Name AS SubjectName,
    e.FirstName + ' ' + e.LastName AS TeacherName
FROM 
    Schedules s
JOIN 
    Classes cl ON s.ClassId = cl.ClassId
JOIN 
    Subjects sub ON s.SubjectId = sub.SubjectId
JOIN 
    Employees e ON sub.EmployeeId = e.EmployeeId;
