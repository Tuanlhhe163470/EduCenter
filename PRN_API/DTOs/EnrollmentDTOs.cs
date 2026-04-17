namespace PRN_API.DTOs
{
    public class EnrollmentRequest
    {
        public int ClassId { get; set; }
        // StudentId if Staff enrolls specific sub-users, else take from Token
        public int StudentId { get; set; }
    }
}
