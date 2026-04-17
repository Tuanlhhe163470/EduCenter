namespace PRN_API.DTOs
{
    public class UserDTO
    {
        public int UserId { get; set; }
        public string Username { get; set; } = null!;
        public string? Email { get; set; }
        public string FullName { get; set; } = null!;
        public bool? IsActive { get; set; }
        public List<string> Roles { get; set; } = new List<string>();
    }

    public class CreateUserDTO
    {
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string? Email { get; set; }
        public string FullName { get; set; } = null!;
        public List<string> Roles { get; set; } = new List<string>();
    }
}
