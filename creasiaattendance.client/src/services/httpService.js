import axios from "axios";

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

const http = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    "Content-Type": "application/json",
  },
});

// Hàm xử lý request chung
const requestHandler = async (method, url, data = null) => {
  try {
    const response = await http({ method, url, data });
    return response.data;
  } catch (error) {
    console.error(`API Error [${method.toUpperCase()}] ${url}:`, error);
    throw error;
  }
};

export { http, requestHandler };
