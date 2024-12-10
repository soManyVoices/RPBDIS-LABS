using System;
using System.Collections.Generic;

namespace EFCoreLINQ.Models;

public class Subject
{
    public int SubjectId { get; set; }
    public string Name { get; set; }
    public string? Description { get; set; }
    public int EmployeeId { get; set; }

    public Employee Employee { get; set; }
    public ICollection<Schedule> Schedules { get; set; } = new HashSet<Schedule>();
}
