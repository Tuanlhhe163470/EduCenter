using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    [Route("ClassStudents")]
    public class ClassStudentsController : Controller
    {
        [Route("Index")]
        public IActionResult Index(int classId)
        {
            ViewBag.ClassId = classId;
            return View();
        }
    }
}
