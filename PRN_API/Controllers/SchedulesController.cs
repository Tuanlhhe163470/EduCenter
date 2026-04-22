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
    public class SchedulesController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public SchedulesController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet("class/{classId}")]
        public async Task<IActionResult> GetByClass(int classId)
        {
            var schedules = await _context.Schedules
                .Where(s => s.ClassId == classId)
                .Include(s => s.Class)
                    .ThenInclude(c => c.Course)
                .Select(s => new
                {
                    s.ScheduleId,
                    s.ClassId,
                    s.DayOfWeek,
                    StartTime = s.StartTime.ToString("HH:mm"),
                    EndTime = s.EndTime.ToString("HH:mm"),
                    s.Room,
                    CourseName = s.Class.Course != null ? s.Class.Course.CourseName : null
                })
                .ToListAsync();

            return Ok(schedules);
        }

        [HttpGet("my-schedules")]
        public async Task<IActionResult> GetMySchedules()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId))
            {
                return Unauthorized();
            }

            if (User.IsInRole("Teacher"))
            {
                var schedules = await _context.Schedules
                    .Where(s => s.Class.TeacherId == userId)
                    .Include(s => s.Class)
                        .ThenInclude(c => c.Course)
                    .Select(s => new
                    {
                        s.ScheduleId,
                        s.ClassId,
                        s.DayOfWeek,
                        StartTime = s.StartTime.ToString("HH:mm"),
                        EndTime = s.EndTime.ToString("HH:mm"),
                        s.Room,
                        CourseName = s.Class.Course != null ? s.Class.Course.CourseName : null
                    })
                    .ToListAsync();
                return Ok(schedules);
            }
            else if (User.IsInRole("Student"))
            {
                var schedules = await _context.Enrollments
                    .Where(e => e.StudentId == userId && e.Status == "Paid")
                    .SelectMany(e => e.Class!.Schedules)
                    .Select(s => new
                    {
                        s.ScheduleId,
                        s.ClassId,
                        s.DayOfWeek,
                        StartTime = s.StartTime.ToString("HH:mm"),
                        EndTime = s.EndTime.ToString("HH:mm"),
                        s.Room,
                        CourseName = s.Class.Course != null ? s.Class.Course.CourseName : null
                    })
                    .ToListAsync();
                return Ok(schedules);
            }

            return Forbid();
        }

        [HttpGet("my-classes")]
        public async Task<IActionResult> GetMyClasses()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int userId)) return Unauthorized();

            if (User.IsInRole("Teacher"))
            {
                var classes = await _context.Classes
                    .Where(c => c.TeacherId == userId)
                    .Include(c => c.Course)
                    .Select(c => new
                    {
                        ClassId = c.ClassId,
                        CourseName = c.Course != null ? c.Course.CourseName : "Lớp " + c.ClassId
                    })
                    .ToListAsync();
                return Ok(classes);
            }
            else if (User.IsInRole("Student"))
            {
                var classes = await _context.Enrollments
                    .Where(e => e.StudentId == userId && e.Status == "Paid")
                    .Include(e => e.Class)
                        .ThenInclude(c => c.Course)
                    .Select(e => new
                    {
                        ClassId = e.ClassId,
                        CourseName = e.Class.Course != null ? e.Class.Course.CourseName : "Lớp " + e.ClassId
                    })
                    .ToListAsync();
                return Ok(classes);
            }
            else if (User.IsInRole("Admin") || User.IsInRole("Staff"))
            {
                var classes = await _context.Classes
                    .Include(c => c.Course)
                    .Select(c => new
                    {
                        ClassId = c.ClassId,
                        CourseName = c.Course != null ? c.Course.CourseName : "Lớp " + c.ClassId
                    })
                    .ToListAsync();
                return Ok(classes);
            }

            return Forbid();
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Staff")]
        public async Task<IActionResult> AddSchedule([FromBody] ScheduleDTO dto)
        {
            if (dto.ClassId <= 0)
                return BadRequest("Vui lòng chọn lớp học.");

            if (string.IsNullOrEmpty(dto.StartTime) || string.IsNullOrEmpty(dto.EndTime))
                return BadRequest("Vui lòng nhập giờ bắt đầu và kết thúc.");

            if (!TimeOnly.TryParse(dto.StartTime, out var startTime))
                return BadRequest("Giờ bắt đầu không hợp lệ.");

            if (!TimeOnly.TryParse(dto.EndTime, out var endTime))
                return BadRequest("Giờ kết thúc không hợp lệ.");

            if (endTime <= startTime)
                return BadRequest("Giờ kết thúc phải sau giờ bắt đầu.");

            var targetClass = await _context.Classes.FindAsync(dto.ClassId);
            if (targetClass == null) return BadRequest("Lớp học không tồn tại.");

            if (targetClass.TeacherId != null && targetClass.TeacherId > 0)
            {
                var overlappingSchedules = await _context.Schedules
                    .Include(s => s.Class)
                    .Where(s => s.Class.TeacherId == targetClass.TeacherId && s.DayOfWeek == dto.DayOfWeek)
                    .ToListAsync();
                
                bool hasConflict = overlappingSchedules.Any(s => startTime < s.EndTime && endTime > s.StartTime);
                
                if (hasConflict)
                    return BadRequest("Giáo viên phụ trách lớp này đã có lịch dạy trùng vào thời gian bạn vừa chọn.");
            }

            var schedule = new Schedule
            {
                ClassId = dto.ClassId,
                DayOfWeek = dto.DayOfWeek,
                StartTime = startTime,
                EndTime = endTime,
                Room = dto.Room
            };
            _context.Schedules.Add(schedule);
            await _context.SaveChangesAsync();
            return Ok(schedule.ScheduleId);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Staff")]
        public async Task<IActionResult> DeleteSchedule(int id)
        {
            var schedule = await _context.Schedules.FindAsync(id);
            if (schedule == null) return NotFound();
            _context.Schedules.Remove(schedule);
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
