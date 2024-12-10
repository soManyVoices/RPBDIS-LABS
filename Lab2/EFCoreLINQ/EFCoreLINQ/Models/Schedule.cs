using System;
using System.Collections.Generic;

namespace EFCoreLINQ.Models;

public class Schedule
{
    public int ScheduleId { get; set; }
    public DateTime Date { get; set; }
    public string DayOfWeek { get; set; }
    public int ClassId { get; set; }
    public int SubjectId { get; set; }
    public TimeSpan StartTime { get; set; }
    public TimeSpan EndTime { get; set; }

    public Class Class { get; set; }
    public Subject Subject { get; set; }
}

