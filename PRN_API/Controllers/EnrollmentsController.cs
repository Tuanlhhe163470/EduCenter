using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN_API.DTOs;
using PRN_API.Models;

namespace PRN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = "Admin,Staff")]
    public class EnrollmentsController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public EnrollmentsController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpPost("register-student")]
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
        public async Task<IActionResult> Enroll([FromBody] EnrollmentRequest dto)
        {
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
                Status = "Pending"
            };

            _context.Enrollments.Add(enrollment);
            await _context.SaveChangesAsync();
            return Ok(enrollment.EnrollmentId);
        }
    }
}
