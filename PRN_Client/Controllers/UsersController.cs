using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class UsersController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
