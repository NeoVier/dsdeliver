import bodyParser from "body-parser";
import cors from "cors";
import "dotenv-safe/config";
import express from "express";
import path from "path";
import "reflect-metadata";
import { createConnection } from "typeorm";
import { __prod__ } from "./constants";
import { Order } from "./entities/order";
import { Product } from "./entities/product";

const main = async () => {
  const conn = await createConnection({
    type: "postgres",
    url: process.env.DATABASE_URL,
    logging: true,
    synchronize: !__prod__,
    migrations: [path.join(__dirname, "./migrations/*")],
    entities: [Order, Product],
  });

  await conn.runMigrations();

  const app = express();

  app.set("trust proxy", 1);

  app.use(
    cors({
      origin: process.env.CORS_ORIGIN,
    })
  );

  app.use(bodyParser.urlencoded({ extended: false }));
  app.use(bodyParser.json());

  app.get("/products", async (_req, res) => {
    const products = await conn.manager.find(Product, {
      order: { name: "ASC" },
    });
    res.send(products);
  });

  app.get("/orders", async (_req, res) => {
    const orders = await conn.manager.find(Order, {
      relations: ["products"],
      where: { status: "pending" },
      order: { id: "ASC" },
    });
    res.send(orders);
  });

  app.post("/orders", async (req, res) => {
    const products = await conn.manager.findByIds(
      Product,
      req.body.products.map((x: any) => x.id),
      { order: { name: "ASC" } }
    );
    const order = { ...req.body, products, status: "pending" } as Order;
    const { id } = await conn.manager.save(Order, order);
    res.send({ id });
  });

  app.put("/orders/:id/delivered", async (req, res) => {
    const order = await conn.manager.update(Order, req.params.id, {
      status: "delivered",
    });
    console.log(order);
    res.send("Ok");
  });

  app.listen(parseInt(process.env.PORT), () => {
    console.log(`server started on localhost:${process.env.PORT}`);
  });
};

main().catch((err) => {
  console.log(err);
});
