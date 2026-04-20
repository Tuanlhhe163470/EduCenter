using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN_API.DTOs;
using PRN_API.Models;
using System.Security.Claims;

namespace PRN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class EnrollmentsController : ControllerBase
    {
        private readonly PrnProjectContext _context;
        private readonly IConfiguration _config;

        public EnrollmentsController(PrnProjectContext context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }

        [HttpGet("my-enrollments")]
        [Authorize(Roles = "Student")]
        public async Task<IActionResult> GetMyEnrollments()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int studentId)) return Unauthorized();

            var enrollments = await _context.Enrollments
                .Where(e => e.StudentId == studentId)
                .Include(e => e.Class)
                    .ThenInclude(c => c.Course)
                .Include(e => e.Grades)
                .Include(e => e.StudentFeedbacks)
                .Select(e => new
                {
                    e.EnrollmentId,
                    e.ClassId,
                    CourseName = e.Class.Course.CourseName,
                    e.Status,
                    e.EnrollDate,
                    Grade = e.Grades.FirstOrDefault(),
                    Feedback = e.StudentFeedbacks.FirstOrDefault()
                })
                .ToListAsync();

            return Ok(enrollments);
        }

        [HttpPost("register-student")]
        [Authorize(Roles = "Admin,Staff")]
        public async Task<IActionResult> RegisterStudent([FromBody] CreateUserDTO dto)
        {
            if (await _context.Users.AnyAsync(u => u.Username == dto.Username))
            {
                return BadRequest("Username already exists.");
            }

            var studentRole = await _context.Roles.FirstOrDefaultAsync(r => r.RoleName == "Student");
            var user = new User
            {
                Username = dto.Username,
                PasswordHash = dto.Password,
                FullName = dto.FullName,
                Email = dto.Email,
                Roles = studentRole != null ? new List<Role> { studentRole } : new List<Role>()
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();
            return Ok(user.UserId);
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Staff,Student")]
        public async Task<IActionResult> Enroll([FromBody] EnrollmentRequest dto)
        {
            if (User.IsInRole("Student"))
            {
                var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (int.TryParse(userIdStr, out int studentId))
                {
                    if (dto.StudentId != studentId) return Forbid("Bạn chỉ được phép đăng ký khóa học cho chính mình.");
                }
            }

            var targetClass = await _context.Classes
                .Include(c => c.Enrollments)
                .FirstOrDefaultAsync(c => c.ClassId == dto.ClassId);

            if (targetClass == null) return NotFound("Class not found.");

            if (targetClass.Enrollments.Count >= targetClass.MaxStudents)
            {
                return BadRequest("Class is already full.");
            }

            if (targetClass.Enrollments.Any(e => e.StudentId == dto.StudentId))
            {
                return BadRequest("Student is already enrolled in this class.");
            }

            var enrollment = new Enrollment
            {
                ClassId = dto.ClassId,
                StudentId = dto.StudentId,
                EnrollDate = dto.EnrollDate ?? DateTime.Now,
                Status = "Pending"
            };

            _context.Enrollments.Add(enrollment);
            await _context.SaveChangesAsync();
            return Ok(enrollment.EnrollmentId);
        }
    }
}
