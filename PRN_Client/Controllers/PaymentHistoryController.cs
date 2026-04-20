using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class PaymentHistoryController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
