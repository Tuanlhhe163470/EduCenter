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
    public class PaymentsController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public PaymentsController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpPost]
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
