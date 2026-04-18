namespace PRN_API.DTOs
{
    public class ScheduleDTO
    {
        public int ScheduleId { get; set; }
        public int ClassId { get; set; }
        public int DayOfWeek { get; set; }
        public string? StartTime { get; set; }
        public string? EndTime { get; set; }
        public string? Room { get; set; }
    }
}
