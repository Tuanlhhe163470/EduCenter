using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PRN_API.DTOs;
using PRN_API.Models;

namespace PRN_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ClassesController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public ClassesController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> GetClasses()
        {
            var classes = await _context.Classes
                .Include(c => c.Course)
                .Include(c => c.Teacher)
                .Select(c => new ClassDetailDTO
                {
                    ClassId = c.ClassId,
                    CourseId = c.CourseId,
                    CourseName = c.Course != null ? c.Course.CourseName : null,
                    TeacherId = c.TeacherId,
                    TeacherName = c.Teacher != null ? c.Teacher.FullName : null,
                    MaxStudents = c.MaxStudents
                }).ToListAsync();

            return Ok(classes);
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Staff")]
        public async Task<IActionResult> OpenClass([FromBody] CreateClassDTO dto)
        {
            var newClass = new Class
            {
                CourseId = dto.CourseId,
                TeacherId = dto.TeacherId,
                MaxStudents = dto.MaxStudents ?? 20
            };

            _context.Classes.Add(newClass);
            await _context.SaveChangesAsync();
            return Ok(newClass.ClassId);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Staff")]
        public async Task<IActionResult> DeleteClass(int id)
        {
            var cls = await _context.Classes.FindAsync(id);
            if (cls == null) return NotFound();
            _context.Classes.Remove(cls);
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
