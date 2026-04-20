using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN_API.Models;

namespace PRN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = "Admin,Staff")]
    public class DashboardController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public DashboardController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet("stats")]
        [AllowAnonymous]
        public async Task<IActionResult> GetStats()
        {
            var courses = await _context.Courses.CountAsync();
            var classes = await _context.Classes.CountAsync();
            var students = await _context.Users.Where(u => u.Roles.Any(r => r.RoleName == "Student")).CountAsync();
            var payments = await _context.Payments.CountAsync();

            return Ok(new
            {
                Courses = courses,
                Classes = classes,
                Users = students,
                Payments = payments
            });
        }

        [HttpGet("recent-enrollments")]
        [AllowAnonymous]
        public async Task<IActionResult> GetRecentEnrollments()
        {
            var recent = await _context.Enrollments
                .Include(e => e.Student)
                .Include(e => e.Class)
                    .ThenInclude(c => c.Course)
                .OrderByDescending(e => e.EnrollDate)
                .Take(5)
                .Select(e => new
                {
                    e.EnrollmentId,
                    StudentName = e.Student.FullName,
                    CourseName = e.Class.Course.CourseName,
                    EnrollDate = e.EnrollDate,
                    Status = e.Status
                })
                .ToListAsync();

            return Ok(recent);
        }

        [HttpGet("monthly-stats")]
        [AllowAnonymous]
        public async Task<IActionResult> GetMonthlyStats()
        {
            var sixMonthsAgo = DateTime.Now.AddMonths(-5);
            var startDate = new DateTime(sixMonthsAgo.Year, sixMonthsAgo.Month, 1);

            var enrollments = await _context.Enrollments
                .Where(e => e.EnrollDate >= startDate)
                .ToListAsync();

            var monthlyData = new List<object>();
            for (int i = 0; i < 6; i++)
            {
                var monthDate = startDate.AddMonths(i);
                var label = monthDate.ToString("MM/yyyy");
                var count = enrollments.Count(e => e.EnrollDate.HasValue && 
                                                 e.EnrollDate.Value.Month == monthDate.Month && 
                                                 e.EnrollDate.Value.Year == monthDate.Year);
                monthlyData.Add(new { Month = label, Count = count });
            }

            return Ok(monthlyData);
        }
    }
}
