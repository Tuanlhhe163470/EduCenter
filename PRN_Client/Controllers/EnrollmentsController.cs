using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class EnrollmentsController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
