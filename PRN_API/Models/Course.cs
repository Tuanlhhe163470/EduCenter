using System;
using System.Collections.Generic;

namespace PRN_API.Models;

public partial class Course
{
    public int CourseId { get; set; }

    public string CourseName { get; set; } = null!;

    public decimal Price { get; set; }

    public int Duration { get; set; }

    public virtual ICollection<Class> Classes { get; set; } = new List<Class>();
}
