using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class AttendanceController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
