namespace PRN_API.DTOs
{
    public class GradeDTO
    {
        public int GradeId { get; set; }
        public int EnrollmentId { get; set; }
        public decimal? AttendanceGrade { get; set; }
        public decimal? MidtermGrade { get; set; }
        public decimal? FinalGrade { get; set; }
        public string? Note { get; set; }
    }

    public class MaterialDTO
    {
        public int MaterialId { get; set; }
        public int ClassId { get; set; }
        public string Title { get; set; } = null!;
        public string? Description { get; set; }
        public string? MaterialType { get; set; }
        public string Url { get; set; } = null!;
        public DateTime? UploadDate { get; set; }
    }

    public class FeedbackDTO
    {
        public int FeedbackId { get; set; }
        public int EnrollmentId { get; set; }
        public string? Comment { get; set; }
        public int? Rating { get; set; }
        public DateTime? CreatedAt { get; set; }
    }
}
