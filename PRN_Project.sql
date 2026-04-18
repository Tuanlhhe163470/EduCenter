USE [master]
GO
/****** Object:  Database [PRN_Project]    Script Date: 4/17/2026 10:56:09 AM ******/
CREATE DATABASE [PRN_Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PRN_Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.KTEAM\MSSQL\DATA\PRN_Project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PRN_Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.KTEAM\MSSQL\DATA\PRN_Project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PRN_Project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRN_Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PRN_Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRN_Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRN_Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRN_Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRN_Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRN_Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PRN_Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRN_Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRN_Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRN_Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRN_Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRN_Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRN_Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRN_Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRN_Project] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PRN_Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRN_Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRN_Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRN_Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRN_Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRN_Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRN_Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRN_Project] SET RECOVERY FULL 
GO
ALTER DATABASE [PRN_Project] SET  MULTI_USER 
GO
ALTER DATABASE [PRN_Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRN_Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRN_Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRN_Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PRN_Project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PRN_Project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PRN_Project', N'ON'
GO
ALTER DATABASE [PRN_Project] SET QUERY_STORE = OFF
GO
USE [PRN_Project]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[AttendanceID] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[IsPresent] [bit] NOT NULL,
	[Note] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[AttendanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[TeacherID] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[MaxStudents] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](100) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Duration] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollments](
	[EnrollmentID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NOT NULL,
	[ClassID] [int] NOT NULL,
	[EnrollDate] [datetime] NULL,
	[Status] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[EnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[EnrollmentID] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[PaymentDate] [datetime] NULL,
	[Method] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedules]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedules](
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NOT NULL,
	[DayOfWeek] [int] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[Room] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/17/2026 10:56:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
	[Email] [varchar](100) NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Attendance] ON 
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (14, 1, 7, 1, N'Present')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (15, 1, 8, 1, N'Present')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (16, 1, 9, 0, N'Absent')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (17, 2, 7, 1, N'Present')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (18, 2, 8, 1, N'Present')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (19, 2, 9, 1, N'Present')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (20, 4, 10, 1, N'Present')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (21, 4, 11, 0, N'Absent')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (22, 4, 12, 1, N'Present')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (23, 6, 7, 1, N'Present')
GO
INSERT [dbo].[Attendance] ([AttendanceID], [ScheduleID], [StudentID], [IsPresent], [Note]) VALUES (24, 6, 13, 1, N'Present')
GO
SET IDENTITY_INSERT [dbo].[Attendance] OFF
GO
SET IDENTITY_INSERT [dbo].[Classes] ON 
GO
INSERT [dbo].[Classes] ([ClassID], [CourseID], [TeacherID], [StartDate], [EndDate], [MaxStudents]) VALUES (1, 1, 4, CAST(N'2026-03-01' AS Date), CAST(N'2026-06-01' AS Date), 15)
GO
INSERT [dbo].[Classes] ([ClassID], [CourseID], [TeacherID], [StartDate], [EndDate], [MaxStudents]) VALUES (2, 2, 5, CAST(N'2026-03-05' AS Date), CAST(N'2026-05-30' AS Date), 20)
GO
INSERT [dbo].[Classes] ([ClassID], [CourseID], [TeacherID], [StartDate], [EndDate], [MaxStudents]) VALUES (3, 3, 4, CAST(N'2026-03-10' AS Date), CAST(N'2026-05-15' AS Date), 25)
GO
INSERT [dbo].[Classes] ([ClassID], [CourseID], [TeacherID], [StartDate], [EndDate], [MaxStudents]) VALUES (4, 4, 6, CAST(N'2026-04-01' AS Date), CAST(N'2026-06-15' AS Date), 12)
GO
INSERT [dbo].[Classes] ([ClassID], [CourseID], [TeacherID], [StartDate], [EndDate], [MaxStudents]) VALUES (5, 5, 5, CAST(N'2026-04-10' AS Date), CAST(N'2026-07-10' AS Date), 18)
GO
INSERT [dbo].[Classes] ([ClassID], [CourseID], [TeacherID], [StartDate], [EndDate], [MaxStudents]) VALUES (6, 6, 6, CAST(N'2026-04-15' AS Date), CAST(N'2026-06-30' AS Date), 20)
GO
INSERT [dbo].[Classes] ([ClassID], [CourseID], [TeacherID], [StartDate], [EndDate], [MaxStudents]) VALUES (7, 7, 4, CAST(N'2026-05-01' AS Date), CAST(N'2026-08-01' AS Date), 10)
GO
SET IDENTITY_INSERT [dbo].[Classes] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [Price], [Duration]) VALUES (1, N'IELTS 6.5 Intensive', CAST(8500000.00 AS Decimal(18, 2)), 36)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [Price], [Duration]) VALUES (2, N'TOEIC 700+ Master', CAST(4500000.00 AS Decimal(18, 2)), 24)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [Price], [Duration]) VALUES (3, N'Tiáº¿ng Anh Giao Tiáº¿p CÆ¡ Báº£n', CAST(3000000.00 AS Decimal(18, 2)), 20)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [Price], [Duration]) VALUES (4, N'IELTS Writing Task 2', CAST(5000000.00 AS Decimal(18, 2)), 16)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [Price], [Duration]) VALUES (5, N'Business English', CAST(6000000.00 AS Decimal(18, 2)), 30)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [Price], [Duration]) VALUES (6, N'English for Kids (6-10)', CAST(2500000.00 AS Decimal(18, 2)), 24)
GO
INSERT [dbo].[Courses] ([CourseID], [CourseName], [Price], [Duration]) VALUES (7, N'TOEFL iBT Preparation', CAST(9000000.00 AS Decimal(18, 2)), 40)
GO
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Enrollments] ON 
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (1, 7, 1, CAST(N'2026-03-01T00:00:00.000' AS DateTime), N'Paid')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (2, 8, 1, CAST(N'2026-03-02T00:00:00.000' AS DateTime), N'Paid')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (3, 9, 1, CAST(N'2026-03-03T00:00:00.000' AS DateTime), N'Pending')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (4, 10, 2, CAST(N'2026-03-05T00:00:00.000' AS DateTime), N'Paid')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (5, 11, 2, CAST(N'2026-03-06T00:00:00.000' AS DateTime), N'Paid')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (6, 12, 2, CAST(N'2026-03-07T00:00:00.000' AS DateTime), N'Pending')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (7, 7, 3, CAST(N'2026-03-10T00:00:00.000' AS DateTime), N'Paid')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (8, 13, 3, CAST(N'2026-03-11T00:00:00.000' AS DateTime), N'Pending')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (9, 14, 4, CAST(N'2026-04-01T00:00:00.000' AS DateTime), N'Paid')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (10, 15, 5, CAST(N'2026-04-10T00:00:00.000' AS DateTime), N'Pending')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (11, 8, 6, CAST(N'2026-04-15T00:00:00.000' AS DateTime), N'Paid')
GO
INSERT [dbo].[Enrollments] ([EnrollmentID], [StudentID], [ClassID], [EnrollDate], [Status]) VALUES (12, 9, 7, CAST(N'2026-05-01T00:00:00.000' AS DateTime), N'Pending')
GO
SET IDENTITY_INSERT [dbo].[Enrollments] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 
GO
INSERT [dbo].[Payments] ([PaymentID], [EnrollmentID], [Amount], [PaymentDate], [Method]) VALUES (1, 1, CAST(8500000.00 AS Decimal(18, 2)), CAST(N'2026-03-01T00:00:00.000' AS DateTime), N'Chuyá»ƒn khoáº£n')
GO
INSERT [dbo].[Payments] ([PaymentID], [EnrollmentID], [Amount], [PaymentDate], [Method]) VALUES (2, 2, CAST(8500000.00 AS Decimal(18, 2)), CAST(N'2026-03-02T00:00:00.000' AS DateTime), N'Tiá»n máº·t')
GO
INSERT [dbo].[Payments] ([PaymentID], [EnrollmentID], [Amount], [PaymentDate], [Method]) VALUES (3, 4, CAST(4500000.00 AS Decimal(18, 2)), CAST(N'2026-03-05T00:00:00.000' AS DateTime), N'Tháº»')
GO
INSERT [dbo].[Payments] ([PaymentID], [EnrollmentID], [Amount], [PaymentDate], [Method]) VALUES (4, 5, CAST(4500000.00 AS Decimal(18, 2)), CAST(N'2026-03-06T00:00:00.000' AS DateTime), N'Chuyá»ƒn khoáº£n')
GO
INSERT [dbo].[Payments] ([PaymentID], [EnrollmentID], [Amount], [PaymentDate], [Method]) VALUES (5, 7, CAST(3000000.00 AS Decimal(18, 2)), CAST(N'2026-03-10T00:00:00.000' AS DateTime), N'Tiá»n máº·t')
GO
INSERT [dbo].[Payments] ([PaymentID], [EnrollmentID], [Amount], [PaymentDate], [Method]) VALUES (6, 9, CAST(5000000.00 AS Decimal(18, 2)), CAST(N'2026-04-01T00:00:00.000' AS DateTime), N'Chuyá»ƒn khoáº£n')
GO
INSERT [dbo].[Payments] ([PaymentID], [EnrollmentID], [Amount], [PaymentDate], [Method]) VALUES (7, 11, CAST(2500000.00 AS Decimal(18, 2)), CAST(N'2026-04-15T00:00:00.000' AS DateTime), N'Tiá»n máº·t')
GO
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Staff')
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (4, N'Student')
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Teacher')
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedules] ON 
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (1, 1, 2, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), N'A101')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (2, 1, 4, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), N'A101')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (3, 1, 6, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), N'A101')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (4, 2, 3, CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), N'B202')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (5, 2, 5, CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), N'B202')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (6, 3, 2, CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), N'C303')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (7, 3, 4, CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), N'C303')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (8, 4, 7, CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), N'A102')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (9, 5, 3, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), N'B201')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (10, 5, 6, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), N'B201')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (12, 7, 2, CAST(N'14:00:00' AS Time), CAST(N'16:30:00' AS Time), N'A103')
GO
INSERT [dbo].[Schedules] ([ScheduleID], [ClassID], [DayOfWeek], [StartTime], [EndTime], [Room]) VALUES (13, 7, 5, CAST(N'14:00:00' AS Time), CAST(N'16:30:00' AS Time), N'A103')
GO
SET IDENTITY_INSERT [dbo].[Schedules] OFF
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (1, 1)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (2, 2)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (3, 2)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (4, 3)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (5, 3)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (6, 3)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (7, 4)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (8, 4)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (9, 4)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (10, 4)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (11, 4)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (12, 4)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (13, 4)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (14, 4)
GO
INSERT [dbo].[UserRoles] ([UserID], [RoleID]) VALUES (15, 4)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (1, N'admin01', N'admin123', N'admin@hrmg3.com', N'Nguyá»…n Quáº£n Trá»‹', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (2, N'staff01', N'staff123', N'staff@hrmg3.com', N'Tráº§n GiÃ¡o Vá»¥', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (3, N'staff02', N'staff123', N'staff02@hrmg3.com', N'LÃ½ Thu NgÃ¢n', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (4, N'teacher01', N'teacher123', N'gv.tuan@hrmg3.com', N'LÃª Minh Tuáº¥n', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (5, N'teacher02', N'teacher123', N'gv.huong@hrmg3.com', N'Pháº¡m Thu HÆ°Æ¡ng', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (6, N'teacher03', N'teacher123', N'gv.son@hrmg3.com', N'VÃµ Thanh SÆ¡n', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (7, N'student01', N'student123', N'hv.an@gmail.com', N'HoÃ ng BÃ¬nh An', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (8, N'student02', N'student123', N'hv.bao@gmail.com', N'NgÃ´ Gia Báº£o', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (9, N'student03', N'student123', N'hv.chau@gmail.com', N'VÅ© Ngá»c ChÃ¢u', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (10, N'student04', N'student123', N'hv.duc@gmail.com', N'Äáº·ng Minh Äá»©c', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (11, N'student05', N'student123', N'hv.em@gmail.com', N'BÃ¹i Thá»‹ Em', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (12, N'student06', N'student123', N'hv.phong@gmail.com', N'Trá»‹nh Quá»‘c Phong', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (13, N'student07', N'student123', N'hv.giang@gmail.com', N'Mai Há»“ng Giang', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (14, N'student08', N'student123', N'hv.hanh@gmail.com', N'LÃ¢m Thá»‹ Háº¡nh', 1)
GO
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [IsActive]) VALUES (15, N'student09', N'student123', N'hv.khoa@gmail.com', N'Phan VÄƒn Khoa', 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [UQ_Attendance]    Script Date: 4/17/2026 10:56:11 AM ******/
ALTER TABLE [dbo].[Attendance] ADD  CONSTRAINT [UQ_Attendance] UNIQUE NONCLUSTERED 
(
	[ScheduleID] ASC,
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_StudentClass]    Script Date: 4/17/2026 10:56:11 AM ******/
ALTER TABLE [dbo].[Enrollments] ADD  CONSTRAINT [UQ_StudentClass] UNIQUE NONCLUSTERED 
(
	[StudentID] ASC,
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B61601913068A]    Script Date: 4/17/2026 10:56:11 AM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E4B11D74F0]    Script Date: 4/17/2026 10:56:11 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534F979E4BA]    Script Date: 4/17/2026 10:56:11 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Classes] ADD  DEFAULT ((20)) FOR [MaxStudents]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (getdate()) FOR [EnrollDate]
GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedules] ([ScheduleID])
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD FOREIGN KEY([ClassID])
REFERENCES [dbo].[Classes] ([ClassID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD FOREIGN KEY([StudentID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([EnrollmentID])
REFERENCES [dbo].[Enrollments] ([EnrollmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD FOREIGN KEY([ClassID])
REFERENCES [dbo].[Classes] ([ClassID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [CHK_ClassDates] CHECK  (([EndDate]>=[StartDate]))
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [CHK_ClassDates]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD CHECK  (([MaxStudents]>(0)))
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD CHECK  (([Duration]>(0)))
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD CHECK  (([Price]>=(0)))
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD CHECK  (([Amount]>(0)))
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD  CONSTRAINT [CHK_Time] CHECK  (([EndTime]>[StartTime]))
GO
ALTER TABLE [dbo].[Schedules] CHECK CONSTRAINT [CHK_Time]
GO
ALTER TABLE [dbo].[Schedules]  WITH CHECK ADD CHECK  (([DayOfWeek]>=(2) AND [DayOfWeek]<=(8)))
GO
USE [master]
GO
ALTER DATABASE [PRN_Project] SET  READ_WRITE 
GO
