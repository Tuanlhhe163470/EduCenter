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

        [HttpGet("{classId}/students")]
        [Authorize(Roles = "Admin,Teacher,Staff")]
        public async Task<IActionResult> GetClassStudents(int classId)
        {
            var targetClass = await _context.Classes.FindAsync(classId);
            if (targetClass == null) return NotFound();

            if (User.IsInRole("Teacher") && !User.IsInRole("Admin"))
            {
                var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (int.TryParse(userIdStr, out int teacherId))
                {
                    if (targetClass.TeacherId != teacherId) return Forbid();
                }
            }

            var students = await _context.Enrollments
                .Where(e => e.ClassId == classId)
                .Include(e => e.Student)
                .Select(e => new
                {
                    e.EnrollmentId,
                    e.StudentId,
                    e.Student!.FullName,
                    e.Student.Email,
                    e.Status
                })
                .ToListAsync();

            return Ok(students);
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Staff")]
        public async Task<IActionResult> OpenClass([FromBody] CreateClassDTO dto)
        {
            var newClass = new Class
            {
                CourseId = dto.CourseId,
                TeacherId = dto.TeacherId,
                MaxStudents = dto.MaxStudents ?? 20,
                StartDate = dto.StartDate,
                EndDate = dto.EndDate
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
