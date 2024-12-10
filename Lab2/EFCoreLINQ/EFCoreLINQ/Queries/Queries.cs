using System;
using System.Linq;
using EFCoreLINQ.Models;
using SchoolDatabase;

namespace EFCoreLINQ.Queries
{
    public class Queries
    {
        private readonly SchoolContext _context;

        public Queries(SchoolContext context)
        {
            _context = context;
        }

        public IQueryable<Student> GetAllStudents(int recordsNumber)
        {
            return _context.Students.Take(recordsNumber);
        }

        public IQueryable<Student> FilterStudentsByClass(string className, int recordsNumber)
        {
            return _context.Students
                .Where(s => s.Class != null && s.Class.Name == className)
                .Take(recordsNumber);
        }

        public IQueryable<object> GroupStudentsByClass(int recordsNumber)
        {
            return _context.Students
                .GroupBy(s => s.Class.Name)
                .Select(g => new
                {
                    ClassName = g.Key,
                    StudentsCount = g.Count(),
                    MinAge = g.Min(s => (DateTime.Now.Year - s.DateOfBirth.Year)),
                    MaxAge = g.Max(s => (DateTime.Now.Year - s.DateOfBirth.Year)),
                    AvgAge = g.Average(s => DateTime.Now.Year - s.DateOfBirth.Year),
                    Students = g.Take(recordsNumber).ToList()
                });
        }

        public IQueryable<object> GetClassSchedules(int recordsNumber)
        {
            return (from schedule in _context.Schedules
                    join subject in _context.Subjects
                    on schedule.SubjectId equals subject.SubjectId
                    join classInfo in _context.Classes
                    on schedule.ClassId equals classInfo.ClassId
                    select new
                    {
                        ClassName = classInfo.Name,
                        SubjectName = subject.Name,
                        DayOfWeek = schedule.DayOfWeek,
                        StartTime = schedule.StartTime,
                        EndTime = schedule.EndTime
                    }).Take(recordsNumber);
        }

        public IQueryable<object> FilterTeachersByPosition(string positionName, int recordsNumber)
        {
            return (from employee in _context.Employees
                    join position in _context.Positions
                    on employee.PositionId equals position.PositionId
                    where position.Name.Contains(positionName)
                    select new
                    {
                        TeacherName = employee.FirstName + " " + employee.LastName,
                        Position = position.Name,
                        Salary = position.Salary
                    }).Take(recordsNumber);
        }

        public void AddStudent(Student student)
        {
            _context.Students.Add(student);
            _context.SaveChanges();
        }       
        public Employee? GetEmployeeById(int employeeId)
        {
            return _context.Employees.SingleOrDefault(e => e.EmployeeId == employeeId);
        }
        public void AddSubject(Subject subject)
        {
            _context.Subjects.Add(subject);
            _context.SaveChanges();
        }

        public void DeleteStudent(string firstName, string lastName)
        {
            var student = _context.Students
                .FirstOrDefault(s => s.FirstName.ToLower() == firstName.ToLower() &&
                                     s.LastName.ToLower() == lastName.ToLower());

            if (student != null)
            {
                _context.Students.Remove(student);
                _context.SaveChanges();              
            }
            else
            {
                Console.WriteLine("Студент не найден.");
            }
        }


        public void DeleteSubject(int subjectId)
        {
            var subject = _context.Subjects.Find(subjectId);
            if (subject != null)
            {
                _context.Subjects.Remove(subject);
                _context.SaveChanges();
            }
        }

        public void UpdateTeacherSalaries(decimal salaryIncrease)
        {
            var teachers = _context.Employees.ToList();
            foreach (var teacher in teachers)
            {
                var position = _context.Positions.Find(teacher.PositionId);
                if (position != null && position.Salary != null)
                {
                    position.Salary += salaryIncrease;
                }
            }
            _context.SaveChanges();
        }
    }
}
