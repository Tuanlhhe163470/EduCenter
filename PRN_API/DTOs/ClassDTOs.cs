namespace PRN_API.DTOs
{
    public class ClassDetailDTO
    {
        public int ClassId { get; set; }
        public int? CourseId { get; set; }
        public string? CourseName { get; set; }
        public int TeacherId { get; set; }
        public string? TeacherName { get; set; }
        public int? MaxStudents { get; set; }
    }

    public class CreateClassDTO
    {
        public int CourseId { get; set; }
        public int TeacherId { get; set; }
        public int? MaxStudents { get; set; }
        public DateOnly StartDate { get; set; }
        public DateOnly EndDate { get; set; }
    }
}
