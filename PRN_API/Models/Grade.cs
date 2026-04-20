using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PRN_API.Models
{
    public class Grade
    {
        [Key]
        public int GradeId { get; set; }
        
        public int EnrollmentId { get; set; }
        
        public decimal? AttendanceGrade { get; set; }
        
        public decimal? MidtermGrade { get; set; }
        
        public decimal? FinalGrade { get; set; }
        
        public string? Note { get; set; }

        [ForeignKey("EnrollmentId")]
        public virtual Enrollment? Enrollment { get; set; }
    }
}
