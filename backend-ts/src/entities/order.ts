import {
  AfterLoad,
  Column,
  CreateDateColumn,
  Entity,
  JoinTable,
  ManyToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Product } from "./product";

type orderStatus = "pending" | "delivered";

@Entity()
export class Order {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  address: string;

  @Column("float")
  latitude: number;

  @Column("float")
  longitude: number;

  @Column()
  status: orderStatus;

  @CreateDateColumn()
  moment: Date;

  @ManyToMany((_type) => Product, (product) => product.orders, {
    cascade: true,
  })
  @JoinTable()
  products: Product[];

  total: number;

  @AfterLoad()
  setTotal() {
    this.total = this.products.reduce(
      (acc, currProduct) => acc + currProduct.price,
      0
    );
  }
}
