using System;
using System.Collections.Generic;

namespace PRN_API.Models;

public partial class Class
{
    public int ClassId { get; set; }

    public int CourseId { get; set; }

    public int TeacherId { get; set; }

    public DateOnly StartDate { get; set; }

    public DateOnly EndDate { get; set; }

    public int? MaxStudents { get; set; }

    public virtual Course Course { get; set; } = null!;

    public virtual ICollection<Enrollment> Enrollments { get; set; } = new List<Enrollment>();

    public virtual ICollection<Schedule> Schedules { get; set; } = new List<Schedule>();

    public virtual User Teacher { get; set; } = null!;
}
