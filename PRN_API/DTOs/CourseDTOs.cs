namespace PRN_API.DTOs
{
    public class CourseDTO
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; } = null!;
        public decimal Price { get; set; }
    }
}
