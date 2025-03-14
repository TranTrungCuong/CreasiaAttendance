namespace CreasiaAttendance.Server.Model
{
    public class EmployeeAttendanceReport
    {
        public string EmployeeCode { get; set; }

        public string EmployeeName { get; set; }

        public string OutletCode { get; set; }

        public string OutletName { get; set; }

        public List<DayAttendance> AttendanceData { get; set; }

        public class DayAttendance
        {
            public string Date { get; set; }
            public double? Hours { get; set; }
        }
    }
}
