import { Product } from "./Product";

export type OrderStatus = "pending" | "delivered";

export type Order = {
  id: number;
  address: string;
  latitude: number;
  longitude: number;
  moment: Date;
  status: OrderStatus;
  products: Product[];
  total: number;
};
