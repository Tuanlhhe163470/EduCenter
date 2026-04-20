using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class GradesController : Controller
    {
        public IActionResult Index(int? classId)
        {
            ViewBag.ClassId = classId;
            return View();
        }
    }
}
