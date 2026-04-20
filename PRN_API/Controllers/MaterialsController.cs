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
    public class MaterialsController : ControllerBase
    {
        private readonly PrnProjectContext _context;

        public MaterialsController(PrnProjectContext context)
        {
            _context = context;
        }

        [HttpGet("class/{classId}")]
        public async Task<IActionResult> GetClassMaterials(int classId)
        {
            var materials = await _context.Materials
                .Where(m => m.ClassId == classId)
                .OrderByDescending(m => m.UploadDate)
                .Select(m => new MaterialDTO
                {
                    MaterialId = m.MaterialId,
                    ClassId = m.ClassId,
                    Title = m.Title,
                    Description = m.Description,
                    MaterialType = m.MaterialType,
                    Url = m.Url,
                    UploadDate = m.UploadDate
                })
                .ToListAsync();

            return Ok(materials);
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Teacher,Staff")]
        public async Task<IActionResult> AddMaterial([FromBody] MaterialDTO dto)
        {
            // Kiểm tra quyền giáo viên
            if (User.IsInRole("Teacher") && !User.IsInRole("Admin"))
            {
                var targetClass = await _context.Classes.FindAsync(dto.ClassId);
                var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (int.TryParse(userIdStr, out int teacherId))
                {
                    if (targetClass != null && targetClass.TeacherId != teacherId) return Forbid();
                }
            }

            var material = new Material
            {
                ClassId = dto.ClassId,
                Title = dto.Title,
                Description = dto.Description,
                MaterialType = dto.MaterialType,
                Url = dto.Url,
                UploadDate = DateTime.Now
            };

            _context.Materials.Add(material);
            await _context.SaveChangesAsync();
            return Ok(material.MaterialId);
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin,Teacher,Staff")]
        public async Task<IActionResult> DeleteMaterial(int id)
        {
            var material = await _context.Materials.FindAsync(id);
            if (material == null) return NotFound();

            if (User.IsInRole("Teacher") && !User.IsInRole("Admin"))
            {
                var targetClass = await _context.Classes.FindAsync(material.ClassId);
                var userIdStr = User.FindFirstValue(ClaimTypes.NameIdentifier);
                if (int.TryParse(userIdStr, out int teacherId))
                {
                    if (targetClass != null && targetClass.TeacherId != teacherId) return Forbid();
                }
            }

            _context.Materials.Remove(material);
            await _context.SaveChangesAsync();
            return Ok();
        }
    }
}
