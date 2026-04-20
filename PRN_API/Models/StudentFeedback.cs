using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PRN_API.Models
{
    public class StudentFeedback
    {
        [Key]
        public int FeedbackId { get; set; }
        
        public int EnrollmentId { get; set; }
        
        public string? Comment { get; set; }
        
        public int? Rating { get; set; }
        
        public DateTime? CreatedAt { get; set; } = DateTime.Now;

        [ForeignKey("EnrollmentId")]
        public virtual Enrollment? Enrollment { get; set; }
    }
}
