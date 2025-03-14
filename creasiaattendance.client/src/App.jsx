import React, { useEffect, useState } from "react";
import { Table, Button, Spin, message } from "antd";
import { attendanceService } from "./services/attendanceService";

const EmployeeAttendance = () => {
    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        fetchEmployeeData();
    }, []);

    const fetchEmployeeData = async () => {
        setLoading(true);
        try {
            const employees = await attendanceService.getData();
            setData(employees);
        } catch (error) {
            message.error("Không thể tải dữ liệu!");
        } finally {
            setLoading(false);
        }
    };

    const transformData = (data) => {
        const employees = {};

        data.forEach((record) => {
            const { employeeCode, employeeName, outletCode, outletName, date, totalHours } = record;
            const formattedDate = new Date(date).toLocaleDateString("en-GB"); // Format ngày dd/MM/yyyy

            if (!employees[employeeCode]) {
                employees[employeeCode] = {
                    key: employeeCode,
                    employeeCode,
                    employeeName,
                    outletCode,
                    outletName,
                };
            }

            employees[employeeCode][formattedDate] = totalHours; // Gán số giờ vào đúng cột ngày
        });

        return Object.values(employees);
    };

    const getColumns = (data) => {
        let dateSet = new Set();

        data.forEach((item) => {
            const formattedDate = new Date(item.date).toLocaleDateString("en-GB");
            dateSet.add(formattedDate);
        });

        let columns = [
            { title: "Mã nhân viên", dataIndex: "employeeCode", key: "employeeCode" },
            { title: "Tên nhân viên", dataIndex: "employeeName", key: "employeeName" },
            { title: "Mã cửa hàng", dataIndex: "outletCode", key: "outletCode" },
            { title: "Tên cửa hàng", dataIndex: "outletName", key: "outletName" },
        ];

        // Thêm các cột ngày vào
        dateSet.forEach((date) => {
            columns.push({
                title: date,
                dataIndex: date,
                key: date,
                align: "center",
            });
        });

        return columns;
    };


    const attendanceTable = (data) => {
        const _data = transformData(data);
        const _columns = getColumns(data);

        return <Table columns={_columns} dataSource={_data} pagination={false} />;
    };

    const handleExport = async () => {
        message.loading("Đang xuất file...");
        try {
            await attendanceService.exportExcel();
            message.success("Xuất file thành công!");
        } catch (error) {
            message.error("Lỗi khi xuất file!");
        }
    };

    return (
        <div>
            <h2>Danh Sách Chấm Công Nhân Viên</h2>
            {loading ? (
                <Spin size="large" />
            ) : (
                <>
                    <Button type="primary" onClick={handleExport} style={{ marginBottom: 16 }}>
                        Xuất Excel
                    </Button>
                    {attendanceTable(data)}
                </>
            )}
        </div>
    );
};

export default EmployeeAttendance;
