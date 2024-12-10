using System;
using System.Collections.Generic;

namespace EFCoreLINQ.Models;

public class ClassType
{
    public int ClassTypeId { get; set; }
    public string Name { get; set; }
    public string? Description { get; set; }

    public ICollection<Class> Classes { get; set; } = new HashSet<Class>();
}
