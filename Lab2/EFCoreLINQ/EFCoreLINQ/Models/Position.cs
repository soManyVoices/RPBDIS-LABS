using System;
using System.Collections.Generic;

namespace EFCoreLINQ.Models;


public class Position
{
    public int PositionId { get; set; }
    public string Name { get; set; }
    public string? Description { get; set; }
    public decimal? Salary { get; set; }

    public ICollection<Employee> Employees { get; set; } = new HashSet<Employee>();
}
