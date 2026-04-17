using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class SchedulesController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
