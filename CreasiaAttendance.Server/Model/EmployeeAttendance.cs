namespace CreasiaAttendance.Server.Model
{
    public class EmployeeAttendance
    {
        public string EmployeeCode { get; set; }

        public string EmployeeName { get; set; }

        public string OutletCode { get; set; }

        public string OutletName { get; set; }

        public DateTime Date { get; set; }

        public double TotalHours { get; set; }
    }
}
