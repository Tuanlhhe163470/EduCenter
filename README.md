# 🏫 Hệ Thống Quản Lý Trung Tâm Tiếng Anh 

> Đồ án môn học PRN232 - Ứng dụng quản lý trung tâm đào tạo tiếng Anh được thiết kế theo kiến trúc Client-Server, đảm bảo tính bảo mật, hiệu năng và chuẩn hóa dữ liệu.

---

## 💻 Công Nghệ Sử Dụng

Dự án được chia thành hai phân hệ độc lập, giao tiếp với nhau thông qua RESTful API.

**1. Backend (API Services)**
* **Framework:** ASP.NET Core Web API (.NET 8)
* **Database:** SQL Server
* **ORM:** Entity Framework Core (Database-First)
* **Bảo mật:** JWT (JSON Web Token), Role-Based Access Control (RBAC)
* **Tiện ích:** OData (hỗ trợ query dữ liệu), DTO (Data Transfer Object)

**2. Frontend (Client App)**
* **Framework:** ASP.NET Core MVC
* **Giao diện:** Bootstrap 5, HTML5, CSS3
* **Xử lý bất đồng bộ:** AJAX, jQuery, `HttpClient`

---

## 🎯 Phân Quyền & Chức Năng Chính

Hệ thống hỗ trợ 4 vai trò (Roles) với các quyền hạn được phân lập rõ ràng bằng JWT Token:

| Vai Trò | Chức Năng Cốt Lõi |
| :--- | :--- |
| **Admin** | Toàn quyền hệ thống. Quản lý tài khoản, phân quyền, cấu hình danh mục khóa học, xem thống kê. |
| **Staff** | Ghi danh học viên, xếp lớp, quản lý thu phí và xuất biên lai thanh toán. |
| **Teacher** | Xem lịch giảng dạy cá nhân, thực hiện điểm danh học viên theo từng buổi học. |
| **Student** | Theo dõi lịch học cá nhân, tra cứu kết quả điểm danh và lịch sử đóng học phí. |

---

## 📂 Cấu Trúc Mã Nguồn

Dự án bao gồm 1 Solution tổng chứa 2 Projects chính:

* `HRM_G3.API/`: Chứa logic nghiệp vụ, kết nối cơ sở dữ liệu và cung cấp các Endpoints API.
* `HRM_G3.Client/`: Chứa giao diện người dùng, gọi API từ Backend và hiển thị dữ liệu.

---

