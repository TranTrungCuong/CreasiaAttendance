USE [master]
GO
/****** Object:  Database [CreasiaAttendance]    Script Date: 3/14/2025 9:17:19 PM ******/
CREATE DATABASE [CreasiaAttendance]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CreasiaAttendance', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.CTT\MSSQL\DATA\CreasiaAttendance.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CreasiaAttendance_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.CTT\MSSQL\DATA\CreasiaAttendance_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CreasiaAttendance] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CreasiaAttendance].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CreasiaAttendance] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET ARITHABORT OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CreasiaAttendance] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CreasiaAttendance] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CreasiaAttendance] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CreasiaAttendance] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET RECOVERY FULL 
GO
ALTER DATABASE [CreasiaAttendance] SET  MULTI_USER 
GO
ALTER DATABASE [CreasiaAttendance] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CreasiaAttendance] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CreasiaAttendance] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CreasiaAttendance] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CreasiaAttendance] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CreasiaAttendance] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CreasiaAttendance', N'ON'
GO
ALTER DATABASE [CreasiaAttendance] SET QUERY_STORE = ON
GO
ALTER DATABASE [CreasiaAttendance] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CreasiaAttendance]
GO
/****** Object:  Table [dbo].[Attendances]    Script Date: 3/14/2025 9:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendances](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[OutletId] [int] NOT NULL,
	[AttendanceDate] [date] NOT NULL,
	[AttendanceType] [varchar](10) NULL,
	[AttendanceTime] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 3/14/2025 9:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] NOT NULL,
	[EmployeeCode] [varchar](10) NOT NULL,
	[EmployeeName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmployeeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Outlets]    Script Date: 3/14/2025 9:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Outlets](
	[OutletId] [int] NOT NULL,
	[OutletCode] [varchar](10) NOT NULL,
	[OutletName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OutletId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[OutletCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Attendances_AttendanceTime]    Script Date: 3/14/2025 9:17:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_Attendances_AttendanceTime] ON [dbo].[Attendances]
(
	[AttendanceTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Attendances_EmployeeId_OutletId_AttendanceDate]    Script Date: 3/14/2025 9:17:19 PM ******/
CREATE NONCLUSTERED INDEX [IX_Attendances_EmployeeId_OutletId_AttendanceDate] ON [dbo].[Attendances]
(
	[EmployeeId] ASC,
	[OutletId] ASC,
	[AttendanceDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Attendances]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO
ALTER TABLE [dbo].[Attendances]  WITH CHECK ADD FOREIGN KEY([OutletId])
REFERENCES [dbo].[Outlets] ([OutletId])
GO
ALTER TABLE [dbo].[Attendances]  WITH CHECK ADD CHECK  (([AttendanceType]='OUT' OR [AttendanceType]='IN'))
GO
/****** Object:  StoredProcedure [dbo].[sp_CalculateWorkHours]    Script Date: 3/14/2025 9:17:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CalculateWorkHours]
AS
BEGIN
    SET NOCOUNT ON;

    -- Đánh số thứ tự cho mỗi lần CheckIn và CheckOut trong ngày
    WITH CheckIns AS (
        SELECT 
            EmployeeId,
            OutletId,
            AttendanceDate,
            AttendanceTime AS CheckIn,
            ROW_NUMBER() OVER (PARTITION BY EmployeeId, OutletId, AttendanceDate ORDER BY AttendanceTime) AS RowNum
        FROM Attendances
        WHERE AttendanceType = 'IN'
    ),
    CheckOuts AS (
        SELECT 
            EmployeeId,
            OutletId,
            AttendanceDate,
            AttendanceTime AS CheckOut,
            ROW_NUMBER() OVER (PARTITION BY EmployeeId, OutletId, AttendanceDate ORDER BY AttendanceTime) AS RowNum
        FROM Attendances
        WHERE AttendanceType = 'OUT'
    ),
    AttendancePairs AS (
        -- Ghép đúng cặp CheckIn - CheckOut theo số thứ tự (RowNum)
        SELECT 
            e.EmployeeCode,
            e.EmployeeName,
            o.OutletCode,
            o.OutletName,
            ci.AttendanceDate,
            ci.CheckIn,
            co.CheckOut,
            DATEDIFF(MINUTE, ci.CheckIn, co.CheckOut) / 60.0 AS HoursWorked
        FROM CheckIns ci
        JOIN CheckOuts co 
            ON ci.EmployeeId = co.EmployeeId 
            AND ci.OutletId = co.OutletId
            AND ci.AttendanceDate = co.AttendanceDate
            AND ci.RowNum = co.RowNum
        JOIN Employees e ON ci.EmployeeId = e.EmployeeId
        JOIN Outlets o ON ci.OutletId = o.OutletId
    )

    -- Cộng tổng số giờ làm trong ngày cho mỗi nhân viên
    SELECT 
        EmployeeCode,
        EmployeeName,
        OutletCode,
        OutletName,
        AttendanceDate,
        SUM(HoursWorked) AS TotalHours  -- Cộng tổng giờ làm trong ngày
    FROM AttendancePairs
    GROUP BY EmployeeCode, EmployeeName, OutletCode, OutletName, AttendanceDate
    ORDER BY EmployeeCode, AttendanceDate;
END;
GO
USE [master]
GO
ALTER DATABASE [CreasiaAttendance] SET  READ_WRITE 
GO
