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
    [Authorize(Roles = "Admin,Teacher,Staff")]
    public class GradesController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public GradesController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet("class/{classId}")]
        public async Task<IActionResult> GetClassGrades(int classId)
        {
            var targetClass = await _context.Classes.FindAsync(classId);
            if (targetClass == null) return NotFound();

            // Kiểm tra quyền giáo viên
            if (User.IsInRole("Teacher") && !User.IsInRole("Admin"))
            {
                var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (int.TryParse(userIdStr, out int teacherId))
                {
                    if (targetClass.TeacherId != teacherId) return Forbid();
                }
            }

            var gradeData = await _context.Enrollments
                .Where(e => e.ClassId == classId)
                .Include(e => e.Student)
                .Include(e => e.Grades)
                .Select(e => new
                {
                    e.EnrollmentId,
                    e.StudentId,
                    e.Student.FullName,
                    Grade = e.Grades.FirstOrDefault() != null ? new GradeDTO
                    {
                        GradeId = e.Grades.FirstOrDefault()!.GradeId,
                        EnrollmentId = e.EnrollmentId,
                        AttendanceGrade = e.Grades.FirstOrDefault()!.AttendanceGrade,
                        MidtermGrade = e.Grades.FirstOrDefault()!.MidtermGrade,
                        FinalGrade = e.Grades.FirstOrDefault()!.FinalGrade,
                        Note = e.Grades.FirstOrDefault()!.Note
                    } : null
                })
                .ToListAsync();

            return Ok(gradeData);
        }

        [HttpPost]
        public async Task<IActionResult> SaveGrades([FromBody] List<GradeDTO> dtos)
        {
            foreach (var dto in dtos)
            {
                var existing = await _context.Grades.FirstOrDefaultAsync(g => g.EnrollmentId == dto.EnrollmentId);
                if (existing != null)
                {
                    existing.AttendanceGrade = dto.AttendanceGrade;
                    existing.MidtermGrade = dto.MidtermGrade;
                    existing.FinalGrade = dto.FinalGrade;
                    existing.Note = dto.Note;
                }
                else
                {
                    _context.Grades.Add(new Grade
                    {
                        EnrollmentId = dto.EnrollmentId,
                        AttendanceGrade = dto.AttendanceGrade,
                        MidtermGrade = dto.MidtermGrade,
                        FinalGrade = dto.FinalGrade,
                        Note = dto.Note
                    });
                }
            }

            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
