using System;
using System.Collections.Generic;

namespace EFCoreLINQ.Models;

public class Employee
{
    public int EmployeeId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string? MiddleName { get; set; }
    public int PositionId { get; set; }

    public Position Position { get; set; }
    public ICollection<Subject> Subjects { get; set; } = new HashSet<Subject>();
}
