using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class MyScheduleController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
