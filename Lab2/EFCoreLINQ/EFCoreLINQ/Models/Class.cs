using System;
using System.Collections.Generic;

namespace EFCoreLINQ.Models;

public class Class
{
    public int ClassId { get; set; }
    public string Name { get; set; }
    public string ClassTeacher { get; set; }
    public int ClassTypeId { get; set; }
    public int StudentCount { get; set; }
    public int YearCreated { get; set; }

    public ClassType ClassType { get; set; }
    public ICollection<Student> Students { get; set; } = new HashSet<Student>();
    public ICollection<Schedule> Schedules { get; set; } = new HashSet<Schedule>();
}
