using System;
using System.Collections.Generic;

namespace EFCoreLINQ.Models;

public class Student
{
    public int StudentId { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string? MiddleName { get; set; }
    public DateTime DateOfBirth { get; set; }
    public string Gender { get; set; }
    public string? Address { get; set; }
    public string? FatherFirstName { get; set; }
    public string? FatherLastName { get; set; }
    public string? FatherMiddleName { get; set; }
    public string? MotherFirstName { get; set; }
    public string? MotherLastName { get; set; }
    public string? MotherMiddleName { get; set; }
    public int? ClassId { get; set; }
    public string? AdditionalInfo { get; set; }

    public Class? Class { get; set; }
}
