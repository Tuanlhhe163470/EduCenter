using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace PRN_Client.Filters
{
    public class AuthFilter : IActionFilter
    {
        private static readonly Dictionary<string, string[]> PageRoles = new()
        {
            { "Courses", new[] { "Admin", "Staff" } },
            { "Classes", new[] { "Admin", "Staff" } },
            { "Enrollments", new[] { "Admin", "Staff" } },
            { "Payments", new[] { "Admin", "Staff" } },
            { "Attendance", new[] { "Admin", "Teacher" } },
            { "Grades", new[] { "Admin", "Teacher" } },
            { "Materials", new[] { "Admin", "Teacher", "Staff", "Student" } },
            { "MyProgress", new[] { "Student" } },
            { "CourseCatalog", new[] { "Student" } },
            { "PaymentHistory", new[] { "Student" } },
            { "Users", new[] { "Admin" } },
            { "ClassStudents", new[] { "Admin", "Teacher" } },
            { "Schedules", new[] { "Admin", "Staff", "Teacher", "Student" } },
            { "MySchedule", new[] { "Admin", "Staff", "Teacher", "Student" } },
            { "Home", new[] { "Admin", "Staff", "Teacher", "Student" } }
        };

        public void OnActionExecuting(ActionExecutingContext context)
        {
            var controller = context.RouteData.Values["controller"]?.ToString();

            if (controller == "Auth" || controller == "Home")
                return;

            var token = context.HttpContext.Session.GetString("JWToken");
            if (string.IsNullOrEmpty(token))
            {
                context.Result = new RedirectToActionResult("Login", "Auth", null);
                return;
            }

            var roles = context.HttpContext.Session.GetString("Roles") ?? "";

            if (controller != null && PageRoles.ContainsKey(controller))
            {
                var allowedRoles = PageRoles[controller];
                var hasAccess = allowedRoles.Any(r => roles.Contains(r));

                if (!hasAccess)
                {
                    context.HttpContext.Session.SetString("AccessDenied", "Bạn không có quyền truy cập trang này.");
                    context.Result = new RedirectToActionResult("Index", "Home", null);
                    return;
                }
            }
        }

        public void OnActionExecuted(ActionExecutedContext context)
        {
        }
    }
}
