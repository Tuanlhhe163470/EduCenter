using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN_API.DTOs;
using PRN_API.Models;

namespace PRN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = "Admin,Teacher")]
    public class AttendanceController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public AttendanceController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet("{scheduleId}")]
        public async Task<IActionResult> GetAttendance(int scheduleId)
        {
            var schedule = await _context.Schedules.Include(s => s.Class).FirstOrDefaultAsync(s => s.ScheduleId == scheduleId);
            if (schedule == null) return NotFound();

            var students = await _context.Enrollments
                .Where(e => e.ClassId == schedule.ClassId)
                .Include(e => e.Student)
                .Select(e => new
                {
                    e.StudentId,
                    e.Student.FullName
                }).ToListAsync();

            return Ok(students);
        }

        [HttpPost("{scheduleId}")]
        public async Task<IActionResult> MarkAttendance(int scheduleId, [FromBody] List<AttendanceRequest> dto)
        {
            foreach (var item in dto)
            {
                var existing = await _context.Attendances.FirstOrDefaultAsync(a => a.ScheduleId == scheduleId && a.StudentId == item.StudentId);
                if (existing != null)
                {
                    existing.Note = item.Note;
                }
                else
                {
                    _context.Attendances.Add(new Attendance
                    {
                        ScheduleId = scheduleId,
                        StudentId = item.StudentId,
                        Note = item.Note
                    });
                }
            }
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
