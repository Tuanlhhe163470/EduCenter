namespace PRN_API.DTOs
{
    public class AttendanceRequest
    {
        public int StudentId { get; set; }
        public string? Note { get; set; } // Can be "Present", "Absent", etc.
    }
}
