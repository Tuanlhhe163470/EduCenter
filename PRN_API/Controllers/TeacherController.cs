using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN_API.Models;
using System.Security.Claims;

namespace PRN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = "Admin,Teacher")]
    public class TeacherController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public TeacherController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet]
        [AllowAnonymous]
        public async Task<IActionResult> GetTeachers()
        {
            var teachers = await _context.Users
                .Include(u => u.Roles)
                .Where(u => u.Roles.Any(r => r.RoleName == "Teacher"))
                .Take(4)
                .Select(u => new {
                    u.UserId,
                    u.FullName,
                    u.Email,
                    Specialization = "Giảng viên chuyên môn"
                })
                .ToListAsync();
            return Ok(teachers);
        }

        [HttpGet("classes/{teacherId}")]
        public async Task<IActionResult> GetTeacherClasses(int teacherId)
        {
            var classes = await _context.Classes
                .Where(c => c.TeacherId == teacherId)
                .Include(c => c.Course)
                .Include(c => c.Schedules)
                .ToListAsync();

            return Ok(classes);
        }
    }
}
