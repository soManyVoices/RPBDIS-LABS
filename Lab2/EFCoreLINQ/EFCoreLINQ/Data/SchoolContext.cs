using System;
using EFCoreLINQ.Models;
using System.Security.Claims;
using Microsoft.EntityFrameworkCore;

namespace SchoolDatabase
{
    public partial class SchoolContext : DbContext
    {
        public SchoolContext()
        {
        }

        public SchoolContext(DbContextOptions<SchoolContext> options)
            : base(options)
        {
        }

        public virtual DbSet<ClassType> ClassTypes { get; set; }
        public virtual DbSet<Class> Classes { get; set; }
        public virtual DbSet<Position> Positions { get; set; }
        public virtual DbSet<Employee> Employees { get; set; }
        public virtual DbSet<Subject> Subjects { get; set; }
        public virtual DbSet<Student> Students { get; set; }
        public virtual DbSet<Schedule> Schedules { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
            => optionsBuilder.UseSqlServer("Server=HOME-PC;Database=School;Trusted_Connection=True;TrustServerCertificate=True");

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ClassType>(entity =>
            {
                entity.HasKey(e => e.ClassTypeId);
                entity.HasIndex(e => e.Name).IsUnique();

                entity.Property(e => e.Name).HasMaxLength(100).IsRequired();
                entity.Property(e => e.Description).HasMaxLength(255);
            });

            modelBuilder.Entity<Class>(entity =>
            {
                entity.HasKey(e => e.ClassId);
                entity.HasIndex(e => e.Name).IsUnique();

                entity.Property(e => e.Name).HasMaxLength(50).IsRequired();
                entity.Property(e => e.ClassTeacher).HasMaxLength(100).IsRequired();
                entity.Property(e => e.YearCreated).IsRequired();
                entity.Property(e => e.StudentCount).HasDefaultValue(0);

                entity.HasOne(e => e.ClassType)
                    .WithMany(ct => ct.Classes)
                    .HasForeignKey(e => e.ClassTypeId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            modelBuilder.Entity<Position>(entity =>
            {
                entity.HasKey(e => e.PositionId);
                entity.HasIndex(e => e.Name).IsUnique();

                entity.Property(e => e.Name).HasMaxLength(100).IsRequired();
                entity.Property(e => e.Description).HasMaxLength(255);
                entity.Property(e => e.Salary).HasColumnType("decimal(10, 2)");
            });

            modelBuilder.Entity<Employee>(entity =>
            {
                entity.HasKey(e => e.EmployeeId);

                entity.Property(e => e.FirstName).HasMaxLength(50).IsRequired();
                entity.Property(e => e.LastName).HasMaxLength(50).IsRequired();
                entity.Property(e => e.MiddleName).HasMaxLength(50);

                entity.HasOne(e => e.Position)
                    .WithMany(p => p.Employees)
                    .HasForeignKey(e => e.PositionId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            modelBuilder.Entity<Subject>(entity =>
            {
                entity.HasKey(e => e.SubjectId);
                entity.HasIndex(e => e.Name).IsUnique();

                entity.Property(e => e.Name).HasMaxLength(100).IsRequired();
                entity.Property(e => e.Description).HasMaxLength(255);

                entity.HasOne(e => e.Employee)
                    .WithMany(emp => emp.Subjects)
                    .HasForeignKey(e => e.EmployeeId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            modelBuilder.Entity<Student>(entity =>
            {
                entity.HasKey(e => e.StudentId);

                entity.Property(e => e.FirstName).HasMaxLength(50).IsRequired();
                entity.Property(e => e.LastName).HasMaxLength(50).IsRequired();
                entity.Property(e => e.MiddleName).HasMaxLength(50);
                entity.Property(e => e.Gender).HasMaxLength(10).IsRequired();
                entity.Property(e => e.Address).HasMaxLength(255);
                entity.Property(e => e.AdditionalInfo).HasMaxLength(255);

                entity.HasOne(e => e.Class)
                    .WithMany(cls => cls.Students)
                    .HasForeignKey(e => e.ClassId)
                    .OnDelete(DeleteBehavior.SetNull);
            });

            modelBuilder.Entity<Schedule>(entity =>
            {
                entity.HasKey(e => e.ScheduleId);

                entity.Property(e => e.DayOfWeek).HasMaxLength(20).IsRequired();
                entity.Property(e => e.StartTime).IsRequired();
                entity.Property(e => e.EndTime).IsRequired();

                entity.HasOne(e => e.Class)
                    .WithMany(cls => cls.Schedules)
                    .HasForeignKey(e => e.ClassId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(e => e.Subject)
                    .WithMany(sub => sub.Schedules)
                    .HasForeignKey(e => e.SubjectId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
