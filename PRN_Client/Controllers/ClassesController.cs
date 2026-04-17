using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class ClassesController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
