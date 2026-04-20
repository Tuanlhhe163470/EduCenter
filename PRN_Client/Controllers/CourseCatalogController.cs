using Microsoft.AspNetCore.Mvc;

namespace PRN_Client.Controllers
{
    public class CourseCatalogController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
