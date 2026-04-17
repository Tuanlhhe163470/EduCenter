using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class PaymentsController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
