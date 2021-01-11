import axios from "axios";

const API_URL = "https://api.dsdeliver.henriquebuss.me";

export const fetchOrders = () => axios(`${API_URL}/orders`);

export const confirmDelivered = (id: number) =>
  axios.put(`${API_URL}/orders/${id}/delivered`);
