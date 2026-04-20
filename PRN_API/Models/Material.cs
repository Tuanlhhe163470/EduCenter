using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PRN_API.Models
{
    public class Material
    {
        [Key]
        public int MaterialId { get; set; }
        
        public int ClassId { get; set; }
        
        [Required]
        [MaxLength(150)]
        public string Title { get; set; } = null!;
        
        [MaxLength(500)]
        public string? Description { get; set; }
        
        [MaxLength(50)]
        public string? MaterialType { get; set; }
        
        [Required]
        [MaxLength(500)]
        public string Url { get; set; } = null!;
        
        public DateTime? UploadDate { get; set; } = DateTime.Now;

        [ForeignKey("ClassId")]
        public virtual Class? Class { get; set; }
    }
}
