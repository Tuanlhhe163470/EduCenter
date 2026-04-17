namespace PRN_API.DTOs
{
    public class PaymentRequest
    {
        public int EnrollmentId { get; set; }
        public decimal Amount { get; set; }
        public string Method { get; set; } = null!;
    }
}
