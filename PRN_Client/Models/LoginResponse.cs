namespace PRN_Client.Models
{
    public class LoginResponse
    {
        public string Token { get; set; } = "";
        public DateTime Expiration { get; set; }
        public int UserId { get; set; }
        public List<string> Roles { get; set; } = new();
    }
}
