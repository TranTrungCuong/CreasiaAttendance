import { requestHandler } from "./httpService";
import { saveAs } from "file-saver";

const ATTENDANCE_ENDPOINT = "/attendance";

const getData = () => requestHandler("get", ATTENDANCE_ENDPOINT);

const exportExcel = async () => {
    try {
        const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

        const url = `${API_BASE_URL}${ATTENDANCE_ENDPOINT}/exportExcel`
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', 'Attendance.xlsx');
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

    } catch (error) {
        console.error("Lỗi xuất file", error);
    }
};


function fetchData() {
    if (!isInternetConnection()) {
        alert('No internet connection.');
        return;
    }
    
    if (!isUser()) {
        alert('User not authenticated.');
        return;
    }

    if (!isAdmin()) {
        alert('Admin role only.');
        return;
    }

    onGetData();
}



export const attendanceService = {
    getData,
    exportExcel
}