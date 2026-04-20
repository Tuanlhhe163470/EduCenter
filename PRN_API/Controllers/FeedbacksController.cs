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
    public class FeedbacksController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public FeedbacksController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet("enrollment/{enrollmentId}")]
        public async Task<IActionResult> GetFeedbackByEnrollment(int enrollmentId)
        {
            var feedback = await _context.StudentFeedbacks
                .Where(f => f.EnrollmentId == enrollmentId)
                .OrderByDescending(f => f.CreatedAt)
                .Select(f => new FeedbackDTO
                {
                    FeedbackId = f.FeedbackId,
                    EnrollmentId = f.EnrollmentId,
                    Comment = f.Comment,
                    Rating = f.Rating,
                    CreatedAt = f.CreatedAt
                })
                .FirstOrDefaultAsync();

            return Ok(feedback);
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Teacher,Staff")]
        public async Task<IActionResult> SaveFeedback([FromBody] FeedbackDTO dto)
        {
            // Kiểm tra quyền giáo viên
            if (User.IsInRole("Teacher") && !User.IsInRole("Admin"))
            {
                var enrollment = await _context.Enrollments.Include(e => e.Class).FirstOrDefaultAsync(e => e.EnrollmentId == dto.EnrollmentId);
                var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (int.TryParse(userIdStr, out int teacherId))
                {
                    if (enrollment != null && enrollment.Class.TeacherId != teacherId) return Forbid();
                }
            }

            var existing = await _context.StudentFeedbacks.FirstOrDefaultAsync(f => f.EnrollmentId == dto.EnrollmentId);
            if (existing != null)
            {
                existing.Comment = dto.Comment;
                existing.Rating = dto.Rating;
                existing.CreatedAt = DateTime.Now;
            }
            else
            {
                _context.StudentFeedbacks.Add(new StudentFeedback
                {
                    EnrollmentId = dto.EnrollmentId,
                    Comment = dto.Comment,
                    Rating = dto.Rating,
                    CreatedAt = DateTime.Now
                });
            }

            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
