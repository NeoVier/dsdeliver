import axios from "axios";

const API_URL = "http://192.168.2.7:3000";

export const fetchOrders = () => axios(`${API_URL}/orders`);
