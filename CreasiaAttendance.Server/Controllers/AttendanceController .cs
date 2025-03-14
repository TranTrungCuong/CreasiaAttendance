using ClosedXML.Excel;
using CreasiaAttendance.Server.Helpers;
using CreasiaAttendance.Server.Model;
using Microsoft.AspNetCore.Mvc;

namespace CreasiaAttendance.Server.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AttendanceController : ControllerBase
{
    private readonly DatabaseHelper _dbHelper;

    public AttendanceController(IConfiguration config)
    {
        _dbHelper = new DatabaseHelper(config.GetConnectionString("DefaultConnection"));
    }

    [HttpGet]
    public async Task<IActionResult> GetAllAttendance()
    {
        var result = await GetEmployeeAttendances();

        return Ok(result);
    }

    [HttpGet("exportExcel")]
    public async Task<IActionResult> ExportToExcel()
    {
        var employeeAttendances = await GetEmployeeAttendances();

        // Xác thực dữ liệu - không hợp lệ có thể return
        // -------------

        // Lấy tất cả các ngày làm việc
        var dates = employeeAttendances.Select(r => r.Date.ToString("dd/MM/yyyy")).Distinct().OrderBy(d => d).ToList();

        // Nhóm dữ liệu theo nhân viên và cửa hàng
        var records = employeeAttendances
            .GroupBy(r => new { r.EmployeeCode, r.EmployeeName, r.OutletCode, r.OutletName })
            .Select(g => new EmployeeAttendanceReport
            {
                EmployeeCode = g.Key.EmployeeCode,
                EmployeeName = g.Key.EmployeeName,
                OutletCode = g.Key.OutletCode,
                OutletName = g.Key.OutletName,
                AttendanceData = dates.Select(date => new EmployeeAttendanceReport.DayAttendance
                {
                    Date = date,
                    Hours = g.FirstOrDefault(r => r.Date.ToString("dd/MM/yyyy") == date)?.TotalHours ?? 0 // Nếu không có dữ liệu thì để 0
                }).ToList()
            })
            .ToList();

        // Tạo file Excel
        using var workbook = new XLWorkbook();
        var worksheet = workbook.Worksheets.Add("Attendance");

        // Tiêu đề cột
        worksheet.Cell(1, 1).Value = "Mã nhân viên";
        worksheet.Cell(1, 2).Value = "Tên nhân viên";
        worksheet.Cell(1, 3).Value = "Mã cửa hàng";
        worksheet.Cell(1, 4).Value = "Tên cửa hàng";

        int col = 5; // Cột bắt đầu cho các ngày
        foreach (var date in dates)
        {
            worksheet.Cell(1, col).Value = date;
            col++;
        }

        // Dữ liệu nhân viên
        int row = 2;
        foreach (var record in records)
        {
            worksheet.Cell(row, 1).Value = record.EmployeeCode;
            worksheet.Cell(row, 2).Value = record.EmployeeName;
            worksheet.Cell(row, 3).Value = record.OutletCode;
            worksheet.Cell(row, 4).Value = record.OutletName;

            int colIndex = 5; // Cột bắt đầu cho các ngày
            foreach (var date in dates)
            {
                var dayAttendance = record.AttendanceData.FirstOrDefault(d => d.Date == date);
                worksheet.Cell(row, colIndex).Value = dayAttendance?.Hours; 
                colIndex++;
            }

            row++;
        }

        // Căn chỉnh cột và hàng
        worksheet.Columns().AdjustToContents();
        worksheet.Rows().AdjustToContents();

        using var stream = new MemoryStream();
        workbook.SaveAs(stream);
        stream.Position = 0;

        return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "Attendance.xlsx");
    }

    // Có thể dời vào service
    private async Task<List<EmployeeAttendance>> GetEmployeeAttendances()
    {
        var records = await _dbHelper.ExecuteStoredProcedure("sp_CalculateWorkHours", reader => new EmployeeAttendance
        {
            EmployeeCode = reader.GetString(0),
            EmployeeName = reader.GetString(1),
            OutletCode = reader.GetString(2),
            OutletName = reader.GetString(3),
            Date = reader.GetDateTime(4),
            TotalHours = Convert.ToDouble(reader.GetDecimal(5))
        });

        return records;
    }
}
