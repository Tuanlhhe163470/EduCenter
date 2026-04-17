USE PRN_Project;
GO

DELETE FROM Attendance;
DELETE FROM Payments;
DELETE FROM Enrollments;
DELETE FROM Schedules;
DELETE FROM Classes;
DELETE FROM Courses;
DELETE FROM UserRoles;
DELETE FROM Users;
DELETE FROM Roles;
GO

SET IDENTITY_INSERT Roles ON;
INSERT INTO Roles (RoleID, RoleName) VALUES (1, 'Admin');
INSERT INTO Roles (RoleID, RoleName) VALUES (2, 'Staff');
INSERT INTO Roles (RoleID, RoleName) VALUES (3, 'Teacher');
INSERT INTO Roles (RoleID, RoleName) VALUES (4, 'Student');
SET IDENTITY_INSERT Roles OFF;
GO

SET IDENTITY_INSERT Users ON;
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (1, 'admin01', 'admin123', N'Nguyễn Quản Trị', 'admin@hrmg3.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (2, 'staff01', 'staff123', N'Trần Giáo Vụ', 'staff@hrmg3.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (3, 'staff02', 'staff123', N'Lý Thu Ngân', 'staff02@hrmg3.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (4, 'teacher01', 'teacher123', N'Lê Minh Tuấn', 'gv.tuan@hrmg3.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (5, 'teacher02', 'teacher123', N'Phạm Thu Hương', 'gv.huong@hrmg3.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (6, 'teacher03', 'teacher123', N'Võ Thanh Sơn', 'gv.son@hrmg3.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (7, 'student01', 'student123', N'Hoàng Bình An', 'hv.an@gmail.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (8, 'student02', 'student123', N'Ngô Gia Bảo', 'hv.bao@gmail.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (9, 'student03', 'student123', N'Vũ Ngọc Châu', 'hv.chau@gmail.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (10, 'student04', 'student123', N'Đặng Minh Đức', 'hv.duc@gmail.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (11, 'student05', 'student123', N'Bùi Thị Em', 'hv.em@gmail.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (12, 'student06', 'student123', N'Trịnh Quốc Phong', 'hv.phong@gmail.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (13, 'student07', 'student123', N'Mai Hồng Giang', 'hv.giang@gmail.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (14, 'student08', 'student123', N'Lâm Thị Hạnh', 'hv.hanh@gmail.com', 1);
INSERT INTO Users (UserID, Username, PasswordHash, FullName, Email, IsActive) VALUES (15, 'student09', 'student123', N'Phan Văn Khoa', 'hv.khoa@gmail.com', 1);
SET IDENTITY_INSERT Users OFF;
GO

INSERT INTO UserRoles (UserID, RoleID) VALUES (1, 1);
INSERT INTO UserRoles (UserID, RoleID) VALUES (2, 2);
INSERT INTO UserRoles (UserID, RoleID) VALUES (3, 2);
INSERT INTO UserRoles (UserID, RoleID) VALUES (4, 3);
INSERT INTO UserRoles (UserID, RoleID) VALUES (5, 3);
INSERT INTO UserRoles (UserID, RoleID) VALUES (6, 3);
INSERT INTO UserRoles (UserID, RoleID) VALUES (7, 4);
INSERT INTO UserRoles (UserID, RoleID) VALUES (8, 4);
INSERT INTO UserRoles (UserID, RoleID) VALUES (9, 4);
INSERT INTO UserRoles (UserID, RoleID) VALUES (10, 4);
INSERT INTO UserRoles (UserID, RoleID) VALUES (11, 4);
INSERT INTO UserRoles (UserID, RoleID) VALUES (12, 4);
INSERT INTO UserRoles (UserID, RoleID) VALUES (13, 4);
INSERT INTO UserRoles (UserID, RoleID) VALUES (14, 4);
INSERT INTO UserRoles (UserID, RoleID) VALUES (15, 4);
GO

SET IDENTITY_INSERT Courses ON;
INSERT INTO Courses (CourseID, CourseName, Price, Duration) VALUES (1, N'IELTS 6.5 Intensive', 8500000, 36);
INSERT INTO Courses (CourseID, CourseName, Price, Duration) VALUES (2, N'TOEIC 700+ Master', 4500000, 24);
INSERT INTO Courses (CourseID, CourseName, Price, Duration) VALUES (3, N'Tiếng Anh Giao Tiếp Cơ Bản', 3000000, 20);
INSERT INTO Courses (CourseID, CourseName, Price, Duration) VALUES (4, N'IELTS Writing Task 2', 5000000, 16);
INSERT INTO Courses (CourseID, CourseName, Price, Duration) VALUES (5, N'Business English', 6000000, 30);
INSERT INTO Courses (CourseID, CourseName, Price, Duration) VALUES (6, N'English for Kids (6-10)', 2500000, 24);
INSERT INTO Courses (CourseID, CourseName, Price, Duration) VALUES (7, N'TOEFL iBT Preparation', 9000000, 40);
SET IDENTITY_INSERT Courses OFF;
GO

SET IDENTITY_INSERT Classes ON;
INSERT INTO Classes (ClassID, CourseID, TeacherID, StartDate, EndDate, MaxStudents) VALUES (1, 1, 4, '2026-03-01', '2026-06-01', 15);
INSERT INTO Classes (ClassID, CourseID, TeacherID, StartDate, EndDate, MaxStudents) VALUES (2, 2, 5, '2026-03-05', '2026-05-30', 20);
INSERT INTO Classes (ClassID, CourseID, TeacherID, StartDate, EndDate, MaxStudents) VALUES (3, 3, 4, '2026-03-10', '2026-05-15', 25);
INSERT INTO Classes (ClassID, CourseID, TeacherID, StartDate, EndDate, MaxStudents) VALUES (4, 4, 6, '2026-04-01', '2026-06-15', 12);
INSERT INTO Classes (ClassID, CourseID, TeacherID, StartDate, EndDate, MaxStudents) VALUES (5, 5, 5, '2026-04-10', '2026-07-10', 18);
INSERT INTO Classes (ClassID, CourseID, TeacherID, StartDate, EndDate, MaxStudents) VALUES (6, 6, 6, '2026-04-15', '2026-06-30', 20);
INSERT INTO Classes (ClassID, CourseID, TeacherID, StartDate, EndDate, MaxStudents) VALUES (7, 7, 4, '2026-05-01', '2026-08-01', 10);
SET IDENTITY_INSERT Classes OFF;
GO

SET IDENTITY_INSERT Schedules ON;
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (1, 1, 2, '08:00', '10:00', 'A101');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (2, 1, 4, '08:00', '10:00', 'A101');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (3, 1, 6, '08:00', '10:00', 'A101');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (4, 2, 3, '14:00', '16:00', 'B202');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (5, 2, 5, '14:00', '16:00', 'B202');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (6, 3, 2, '18:00', '20:00', 'C303');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (7, 3, 4, '18:00', '20:00', 'C303');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (8, 4, 7, '09:00', '11:00', 'A102');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (9, 5, 3, '08:00', '10:00', 'B201');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (10, 5, 6, '08:00', '10:00', 'B201');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (11, 6, 1, '09:00', '11:00', 'D401');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (12, 7, 2, '14:00', '16:30', 'A103');
INSERT INTO Schedules (ScheduleID, ClassID, DayOfWeek, StartTime, EndTime, Room) VALUES (13, 7, 5, '14:00', '16:30', 'A103');
SET IDENTITY_INSERT Schedules OFF;
GO

SET IDENTITY_INSERT Enrollments ON;
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (1, 7, 1, '2026-03-01', 'Paid');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (2, 8, 1, '2026-03-02', 'Paid');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (3, 9, 1, '2026-03-03', 'Pending');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (4, 10, 2, '2026-03-05', 'Paid');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (5, 11, 2, '2026-03-06', 'Paid');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (6, 12, 2, '2026-03-07', 'Pending');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (7, 7, 3, '2026-03-10', 'Paid');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (8, 13, 3, '2026-03-11', 'Pending');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (9, 14, 4, '2026-04-01', 'Paid');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (10, 15, 5, '2026-04-10', 'Pending');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (11, 8, 6, '2026-04-15', 'Paid');
INSERT INTO Enrollments (EnrollmentID, StudentID, ClassID, EnrollDate, Status) VALUES (12, 9, 7, '2026-05-01', 'Pending');
SET IDENTITY_INSERT Enrollments OFF;
GO

SET IDENTITY_INSERT Payments ON;
INSERT INTO Payments (PaymentID, EnrollmentID, Amount, Method, PaymentDate) VALUES (1, 1, 8500000, N'Chuyển khoản', '2026-03-01');
INSERT INTO Payments (PaymentID, EnrollmentID, Amount, Method, PaymentDate) VALUES (2, 2, 8500000, N'Tiền mặt', '2026-03-02');
INSERT INTO Payments (PaymentID, EnrollmentID, Amount, Method, PaymentDate) VALUES (3, 4, 4500000, N'Thẻ', '2026-03-05');
INSERT INTO Payments (PaymentID, EnrollmentID, Amount, Method, PaymentDate) VALUES (4, 5, 4500000, N'Chuyển khoản', '2026-03-06');
INSERT INTO Payments (PaymentID, EnrollmentID, Amount, Method, PaymentDate) VALUES (5, 7, 3000000, N'Tiền mặt', '2026-03-10');
INSERT INTO Payments (PaymentID, EnrollmentID, Amount, Method, PaymentDate) VALUES (6, 9, 5000000, N'Chuyển khoản', '2026-04-01');
INSERT INTO Payments (PaymentID, EnrollmentID, Amount, Method, PaymentDate) VALUES (7, 11, 2500000, N'Tiền mặt', '2026-04-15');
SET IDENTITY_INSERT Payments OFF;
GO

INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (1, 7, 1, 'Present');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (1, 8, 1, 'Present');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (1, 9, 0, 'Absent');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (2, 7, 1, 'Present');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (2, 8, 1, 'Present');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (2, 9, 1, 'Present');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (4, 10, 1, 'Present');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (4, 11, 0, 'Absent');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (4, 12, 1, 'Present');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (6, 7, 1, 'Present');
INSERT INTO Attendance (ScheduleID, StudentID, IsPresent, Note) VALUES (6, 13, 1, 'Present');
GO

PRINT 'Seed data inserted successfully!';
PRINT '';
PRINT 'Login accounts:';
PRINT '  admin01 / admin123  (Admin)';
PRINT '  staff01 / staff123  (Staff)';
PRINT '  teacher01 / teacher123  (Teacher)';
PRINT '  student01 / student123  (Student)';
GO
