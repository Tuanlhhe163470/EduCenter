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
    public class PaymentsController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public PaymentsController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet("my-payments")]
        [Authorize(Roles = "Student")]
        public async Task<IActionResult> GetMyPayments()
        {
            var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (!int.TryParse(userIdStr, out int studentId)) return Unauthorized();

            var payments = await _context.Payments
                .Where(p => p.Enrollment.StudentId == studentId)
                .Include(p => p.Enrollment)
                    .ThenInclude(e => e.Class)
                        .ThenInclude(c => c.Course)
                .OrderByDescending(p => p.PaymentDate)
                .Select(p => new
                {
                    p.PaymentId,
                    CourseName = p.Enrollment.Class.Course.CourseName,
                    p.Amount,
                    p.Method,
                    p.PaymentDate
                })
                .ToListAsync();

            return Ok(payments);
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Staff")]
        public async Task<IActionResult> CreatePayment([FromBody] PaymentRequest dto)
        {
            var enrollment = await _context.Enrollments.FindAsync(dto.EnrollmentId);
            if (enrollment == null) return NotFound("Enrollment not found.");

            var payment = new Payment
            {
                EnrollmentId = dto.EnrollmentId,
                Amount = dto.Amount,
                Method = dto.Method,
            };

            _context.Payments.Add(payment);

            enrollment.Status = "Paid";

            await _context.SaveChangesAsync();
            return Ok(payment.PaymentId);
        }
    }
}
