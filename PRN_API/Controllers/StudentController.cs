using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN_API.Models;

namespace PRN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = "Admin,Student")]
    public class StudentController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public StudentController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet("schedules/{studentId}")]
        public async Task<IActionResult> GetStudentSchedules(int studentId)
        {
            var schedules = await _context.Enrollments
                .Where(e => e.StudentId == studentId)
                .Include(e => e.Class)
                    .ThenInclude(c => c!.Schedules)
                .SelectMany(e => e.Class!.Schedules)
                .ToListAsync();

            return Ok(schedules);
        }
    }
}
