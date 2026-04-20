using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using System.Text;
using PRN_Client.Models;

namespace PRN_Client.Controllers
{
    public class AuthController : Controller
    {
        private readonly IHttpClientFactory _clientFactory;

        public AuthController(IHttpClientFactory clientFactory)
        {
            _clientFactory = clientFactory;
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string username, string password)
        {
            var client = _clientFactory.CreateClient();
            var loginData = new { Username = username, Password = password };
            var content = new StringContent(JsonSerializer.Serialize(loginData), Encoding.UTF8, "application/json");

            var response = await client.PostAsync("http://localhost:5054/api/Auth/login", content);

            if (response.IsSuccessStatusCode)
            {
                var responseContent = await response.Content.ReadAsStringAsync();
                var result = JsonSerializer.Deserialize<LoginResponse>(responseContent, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

                var rolesStr = string.Join(", ", result?.Roles ?? new List<string>());
                HttpContext.Session.SetString("JWToken", result?.Token ?? "");
                HttpContext.Session.SetString("Roles", rolesStr);
                HttpContext.Session.SetString("Username", username);
                HttpContext.Session.SetString("UserId", result?.UserId.ToString() ?? "0");

                if (!rolesStr.Contains("Admin") && !rolesStr.Contains("Staff") && (rolesStr.Contains("Teacher") || rolesStr.Contains("Student")))
                {
                    return RedirectToAction("Index", "MySchedule");
                }

                return RedirectToAction("Index", "Home");
            }

            ViewBag.Error = "Sai tên đăng nhập hoặc mật khẩu!";
            return View();
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Register(string username, string fullName, string email, string password)
        {
            var client = _clientFactory.CreateClient();
            var regData = new { Username = username, FullName = fullName, Email = email, Password = password };
            var content = new StringContent(JsonSerializer.Serialize(regData), Encoding.UTF8, "application/json");

            var response = await client.PostAsync("http://localhost:5054/api/Auth/register", content);

            if (response.IsSuccessStatusCode)
            {
                TempData["SuccessMessage"] = "Đăng ký thành công! Vui lòng đăng nhập.";
                return RedirectToAction("Login");
            }

            var error = await response.Content.ReadAsStringAsync();
            ViewBag.Error = error;
            return View();
        }
    }
}
