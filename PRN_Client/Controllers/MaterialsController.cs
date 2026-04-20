using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class MaterialsController : Controller
    {
        public IActionResult Index(int? classId)
        {
            ViewBag.ClassId = classId;
            return View();
        }
    }
}
