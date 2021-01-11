import cors from "cors";
import "dotenv-safe/config";
import express from "express";
import path from "path";
import "reflect-metadata";
import { createConnection } from "typeorm";
import { Order } from "./entities/order";
import { Product } from "./entities/product";

const main = async () => {
  const conn = await createConnection({
    type: "postgres",
    // url: process.env.DATABASE_URL,
    database: "dsdeliver2",
    logging: true,
    synchronize: true,
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

  app.get("/products", async (_res, req) => {
    const products = await conn.manager.find(Product);
    req.send(products);
  });

  app.get("/orders", async (_res, req) => {
    const orders = await conn.manager.find(Order, { relations: ["products"] });
    req.send(orders);
  });
  // populateDb(conn);

  // const order = await conn.manager.findOne(Order, { relations: ["products"] });
  // console.log("HEllo");
  // console.log(order);

  app.listen(parseInt(process.env.PORT), () => {
    console.log(`server started on localhost:${process.env.PORT}`);
  });
};

main().catch((err) => {
  console.log(err);
});
