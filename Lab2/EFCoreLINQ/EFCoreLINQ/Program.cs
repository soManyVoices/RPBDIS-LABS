using System;
using EFCoreLINQ.Models;
using EFCoreLINQ.Queries;
using SchoolDatabase;

using var context = new SchoolContext();
var queries = new Queries(context);

while (true)
{
    Console.Clear();
    Console.WriteLine("|=================================================================================================================|");
    Console.WriteLine("|                                                  Меню                                                           |");
    Console.WriteLine("| 1. Показать всех студентов - Выборка всех данных из таблицы Student.                                            |");
    Console.WriteLine("| 2. Фильтрация студентов по классу - Выборка студентов, отфильтрованных по классу.                               |");
    Console.WriteLine("| 3. Группировка студентов по классу - Группировка студентов по классу и вывод итоговых данных.                   |");
    Console.WriteLine("| 4. Выборка расписания классов - Выборка данных из таблиц Schedule и Subject.                                    |");
    Console.WriteLine("| 5. Фильтрация учителей по должности - Выборка учителей, отфильтрованных по должности.                           |");
    Console.WriteLine("| 6. Добавить нового студента - Вставка данных в таблицу Student.                                                 |");
    Console.WriteLine("| 7. Добавить новый предмет - Вставка данных в таблицу Subject.                                                   |");
    Console.WriteLine("| 8. Удалить студента - Удаление данных из таблицы Student по имени.                                              |");
    Console.WriteLine("| 9. Удалить предмет - Удаление данных из таблицы Subject по ID.                                                  |");
    Console.WriteLine("| 10. Обновить зарплаты учителей - Обновление записей в таблице Position.                                         |");
    Console.WriteLine("| 0. Выход                                                                                                        |");
    Console.WriteLine("|=================================================================================================================|");
    Console.Write("Выберите опцию: ");
    var option = Console.ReadLine();

    switch (option)
    {
        case "1":
            ShowAllStudents(queries);
            break;
        case "2":
            FilterStudents(queries);
            break;
        case "3":
            GroupStudentsByClass(queries);
            break;
        case "4":
            ShowClassSchedules(queries);
            break;
        case "5":
            FilterTeachersByPosition(queries);
            break;
        case "6":
            AddNewStudent(queries);
            break;
        case "7":
            AddNewSubject(queries);
            break;
        case "8":
            DeleteStudentByName(queries);
            break;
        case "9":
            DeleteSubject(queries);
            break;
        case "10":
            UpdateTeacherSalaries(queries);
            break;
        case "0":
            return;
        default:
            Console.WriteLine("Неверный выбор. Попробуйте снова.");
            break;
    }
}

void ShowAllStudents(Queries service)
{
    Console.Clear();
    Console.Write("Введите количество студентов для показа: ");
    if (!int.TryParse(Console.ReadLine(), out var recordsNumber))
    {
        Console.WriteLine("Некорректное число.");
        return;
    }

    var students = service.GetAllStudents(recordsNumber);
    foreach (var student in students.ToList())
    {
        Console.WriteLine($"ID: {student.StudentId}, Имя: {student.FirstName} {student.LastName}, Дата рождения: {student.DateOfBirth:yyyy-MM-dd}");
    }

    Console.WriteLine("Нажмите любую клавишу для возврата в меню.");
    Console.ReadKey();
}

void FilterStudents(Queries service)
{
    Console.Clear();
    Console.Write("Введите название класса для фильтрации: ");
    var className = Console.ReadLine();

    Console.Write("Введите количество студентов для показа: ");
    if (!int.TryParse(Console.ReadLine(), out var recordsNumber))
    {
        Console.WriteLine("Некорректное число.");
        return;
    }

    var students = service.FilterStudentsByClass(className, recordsNumber);
    foreach (var student in students.ToList())
    {
        Console.WriteLine($"ID: {student.StudentId}, Имя: {student.FirstName} {student.LastName}, Дата рождения: {student.DateOfBirth:yyyy-MM-dd}");
    }

    Console.WriteLine("Нажмите любую клавишу для возврата в меню.");
    Console.ReadKey();
}

void GroupStudentsByClass(Queries service)
{
    Console.Clear();
    Console.Write("Введите количество студентов в каждой группе: ");
    if (!int.TryParse(Console.ReadLine(), out var recordsNumber))
    {
        Console.WriteLine("Некорректное число.");
        return;
    }

    var groups = service.GroupStudentsByClass(recordsNumber);
    foreach (dynamic group in groups)
    {
        Console.WriteLine($"Класс: {group.ClassName}, Количество студентов: {group.StudentsCount}, Средний возраст: {group.AvgAge}");
        foreach (var student in group.Students)
        {
            Console.WriteLine($" - {student.FirstName} {student.LastName}");
        }
    }

    Console.WriteLine("Нажмите любую клавишу для возврата в меню.");
    Console.ReadKey();
}

void ShowClassSchedules(Queries service)
{
    Console.Clear();
    Console.Write("Введите количество записей для показа: ");
    if (!int.TryParse(Console.ReadLine(), out var recordsNumber))
    {
        Console.WriteLine("Некорректное число.");
        return;
    }

    var schedules = service.GetClassSchedules(recordsNumber);
    foreach (dynamic schedule in schedules.ToList())
    {
        Console.WriteLine($"Класс: {schedule.ClassName}, Предмет: {schedule.SubjectName}, День: {schedule.DayOfWeek}, Время: {schedule.StartTime}-{schedule.EndTime}");
    }

    Console.WriteLine("Нажмите любую клавишу для возврата в меню.");
    Console.ReadKey();
}

void FilterTeachersByPosition(Queries service)
{
    Console.Clear();
    Console.Write("Введите название должности для фильтрации: ");
    var positionName = Console.ReadLine();

    Console.Write("Введите количество записей для показа: ");
    if (!int.TryParse(Console.ReadLine(), out var recordsNumber))
    {
        Console.WriteLine("Некорректное число.");
        return;
    }

    var teachers = service.FilterTeachersByPosition(positionName, recordsNumber);
    foreach (dynamic teacher in teachers.ToList())
    {
        Console.WriteLine($"Учитель: {teacher.TeacherName}, Должность: {teacher.Position}, Зарплата: {teacher.Salary}");
    }

    Console.WriteLine("Нажмите любую клавишу для возврата в меню.");
    Console.ReadKey();
}

void AddNewStudent(Queries service)
{
    Console.Clear();

    // Ввод имени студента
    Console.Write("Введите имя студента: ");
    var firstName = Console.ReadLine();
    if (string.IsNullOrWhiteSpace(firstName))
    {
        Console.WriteLine("Имя не может быть пустым.");
        return;
    }

    // Ввод фамилии студента
    Console.Write("Введите фамилию студента: ");
    var lastName = Console.ReadLine();
    if (string.IsNullOrWhiteSpace(lastName))
    {
        Console.WriteLine("Фамилия не может быть пустой.");
        return;
    }

    // Ввод отчества студента (необязательное поле)
    Console.Write("Введите отчество студента (оставьте пустым, если нет): ");
    var middleName = Console.ReadLine();

    // Ввод даты рождения
    Console.Write("Введите дату рождения студента (yyyy-MM-dd): ");
    if (!DateTime.TryParse(Console.ReadLine(), out var dateOfBirth))
    {
        Console.WriteLine("Некорректная дата.");
        return;
    }

    // Ввод пола студента (Мужской/Женский)
    string gender;
    while (true)
    {
        Console.Write("Введите пол студента (Мужской/Женский): ");
        gender = Console.ReadLine()?.Trim();
        if (gender == "Мужской" || gender == "Женский")
        {
            break;
        }
        Console.WriteLine("Пол должен быть 'Мужской' или 'Женский'. Попробуйте снова.");
    }

    // Ввод адреса студента (необязательное поле)
    Console.Write("Введите адрес студента (оставьте пустым, если нет): ");
    var address = Console.ReadLine();

    // Ввод данных о отце (необязательные поля)
    Console.Write("Введите имя отца студента (оставьте пустым, если нет): ");
    var fatherFirstName = Console.ReadLine();
    Console.Write("Введите фамилию отца студента (оставьте пустым, если нет): ");
    var fatherLastName = Console.ReadLine();
    Console.Write("Введите отчество отца студента (оставьте пустым, если нет): ");
    var fatherMiddleName = Console.ReadLine();

    // Ввод данных о матери (необязательные поля)
    Console.Write("Введите имя матери студента (оставьте пустым, если нет): ");
    var motherFirstName = Console.ReadLine();
    Console.Write("Введите фамилию матери студента (оставьте пустым, если нет): ");
    var motherLastName = Console.ReadLine();
    Console.Write("Введите отчество матери студента (оставьте пустым, если нет): ");
    var motherMiddleName = Console.ReadLine();

    // Ввод ID класса (необязательное поле)
    Console.Write("Введите ID класса (оставьте пустым, если нет): ");
    if (!int.TryParse(Console.ReadLine(), out var classId) && !string.IsNullOrWhiteSpace(Console.ReadLine()))
    {
        Console.WriteLine("Некорректный ID класса.");
        return;
    }

    // Ввод дополнительной информации (необязательное поле)
    Console.Write("Введите дополнительную информацию о студенте (оставьте пустым, если нет): ");
    var additionalInfo = Console.ReadLine();

    // Создание нового студента
    var newStudent = new Student
    {
        FirstName = firstName,
        LastName = lastName,
        MiddleName = middleName,
        DateOfBirth = dateOfBirth,
        Gender = gender,
        Address = address,
        FatherFirstName = fatherFirstName,
        FatherLastName = fatherLastName,
        FatherMiddleName = fatherMiddleName,
        MotherFirstName = motherFirstName,
        MotherLastName = motherLastName,
        MotherMiddleName = motherMiddleName,
        ClassId = classId != 0 ? classId : null, // если ID класса не указан, сохраняем как null
        AdditionalInfo = additionalInfo
    };

    try
    {
        service.AddStudent(newStudent);
        Console.WriteLine("Студент успешно добавлен!");
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Ошибка при добавлении студента: {ex.Message}");
        if (ex.InnerException != null)
        {
            Console.WriteLine($"Подробнее: {ex.InnerException.Message}");
        }
    }

    Console.WriteLine("Нажмите любую клавишу для возврата в меню.");
    Console.ReadKey();
}


void AddNewSubject(Queries service)
{
    Console.Clear();

   
    Console.Write("Введите ID сотрудника (EmployeeId), который будет связан с предметом: ");
    if (!int.TryParse(Console.ReadLine(), out var employeeId))
    {
        Console.WriteLine("Некорректный ID сотрудника.");
        return;
    }

   
    var employee = service.GetEmployeeById(employeeId);
    if (employee == null)
    {
        Console.WriteLine("Сотрудник с таким ID не найден.");
        return; 
    }

   
    Console.Write("Введите название предмета: ");
    var subjectName = Console.ReadLine();
   
    var newSubject = new Subject
    {
        Name = subjectName,
        EmployeeId = employeeId 
    };

    service.AddSubject(newSubject);

    Console.WriteLine("Предмет успешно добавлен!");
    Console.ReadKey();
}


void DeleteStudentByName(Queries service)
{
    Console.Clear();
    Console.Write("Введите имя студента для удаления: ");
    var firstName = Console.ReadLine();
    Console.Write("Введите фамилию студента для удаления: ");
    var lastName = Console.ReadLine();

    service.DeleteStudent(firstName, lastName);
    Console.WriteLine("Студент успешно удален!");
    Console.ReadKey();
}

void DeleteSubject(Queries service)
{
    Console.Clear();
    Console.Write("Введите ID предмета для удаления: ");
    if (!int.TryParse(Console.ReadLine(), out var subjectId))
    {
        Console.WriteLine("Некорректный ID.");
        return;
    }

    service.DeleteSubject(subjectId);
    Console.WriteLine("Предмет успешно удален!");
    Console.ReadKey();
}

void UpdateTeacherSalaries(Queries service)
{
    Console.Clear();
    Console.Write("Введите сумму повышения зарплаты: ");
    if (!decimal.TryParse(Console.ReadLine(), out var salaryIncrease))
    {
        Console.WriteLine("Некорректная сумма.");
        return;
    }

    service.UpdateTeacherSalaries(salaryIncrease);
    Console.WriteLine("Зарплаты учителей успешно обновлены!");
    Console.ReadKey();
}
