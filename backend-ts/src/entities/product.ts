import { Column, Entity, ManyToMany, PrimaryGeneratedColumn } from "typeorm";
import { Order } from "./order";

@Entity()
export class Product {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column("float")
  price: number;

  @Column()
  description: string;

  @Column()
  imageUri: string;

  @ManyToMany((_type) => Order, (order) => order.products)
  orders: Order[];
}
