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
    public class SchedulesController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public SchedulesController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpPost]
        public async Task<IActionResult> AddSchedule([FromBody] ScheduleDTO dto)
        {
            var schedule = new Schedule
            {
                ClassId = dto.ClassId,
                DayOfWeek = dto.DayOfWeek,
                StartTime = dto.StartTime,
                EndTime = dto.EndTime,
                Room = dto.Room
            };
            _context.Schedules.Add(schedule);
            await _context.SaveChangesAsync();
            return Ok(schedule.ScheduleId);
        }
    }
}
