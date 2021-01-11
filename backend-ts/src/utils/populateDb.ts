import { Order } from "src/entities/order";
import { Product } from "src/entities/product";
import { Connection } from "typeorm";

export const populateDb = (conn: Connection) => {
  const product1 = new Product();
  product1.name = "Pizza Bacon";
  product1.price = 49.9;
  product1.imageUri =
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_bacon.jpg";
  product1.description =
    "Pizza de bacon com mussarela, orégano, molho especial e tempero da casa.";
  const product2 = new Product();
  product2.name = "Pizza Moda da Casa";
  product2.price = 59.9;
  product2.imageUri =
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_moda.jpg";
  product2.description =
    "Pizza à moda da casa, com molho especial e todos ingredientes básicos, e queijo à sua escolha.";
  const product3 = new Product();
  product3.name = "Pizza Portuguesa";
  product3.price = 45.0;
  product3.imageUri =
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_portuguesa.jpg";
  product3.description =
    "Pizza Portuguesa com molho especial, mussarela, presunto, ovos e especiarias.";
  const product4 = new Product();
  product4.name = "Risoto de Carne";
  product4.price = 52.0;
  product4.imageUri =
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/risoto_carne.jpg";
  product4.description =
    "Risoto de carne com especiarias e um delicioso molho de acompanhamento.";
  const product5 = new Product();
  product5.name = "Risoto Funghi";
  product5.price = 59.95;
  product5.imageUri =
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/risoto_funghi.jpg";
  product5.description =
    "Risoto Funghi feito com ingredientes finos e o toque especial do chef.";
  const product6 = new Product();
  product6.name = "Macarrão Espaguete";
  product6.price = 35.9;
  product6.imageUri =
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_espaguete.jpg";
  product6.description =
    "Macarrão fresco espaguete com molho especial e tempero da casa.";
  const product7 = new Product();
  product7.name = "Macarrão Fusili";
  product7.price = 38.0;
  product7.imageUri =
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_fusili.jpg";
  product7.description = "Macarrão fusili com toque do chef e especiarias.";
  const product8 = new Product();
  product8.name = "Macarrão Penne";
  product8.price = 37.9;
  product8.imageUri =
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_penne.jpg";
  product8.description = "Macarrão penne fresco ao dente com tempero especial.";

  const order1 = new Order();
  order1.status = "pending";
  order1.latitude = -23.56168;
  order1.longitude = -46.656139;
  order1.address = "Avenida Paulista, 1500";
  order1.products = [product1, product4];

  const order2 = new Order();
  order2.status = "delivered";
  order2.latitude = -22.946779;
  order2.longitude = -43.217753;
  order2.address = "Avenida Paulista , 1500";
  order2.products = [product2, product5, product8];

  const order3 = new Order();
  order3.status = "pending";
  order3.latitude = -25.439787;
  order3.longitude = -49.237759;
  order3.address = "Avenida Paulista, 1500";
  order3.products = [product3, product4];

  const order4 = new Order();
  order4.status = "pending";
  order4.latitude = -23.56168;
  order4.longitude = -46.656139;
  order4.address = "Avenida Paulista, 1500";
  order4.products = [product2, product6];

  const order5 = new Order();
  order5.status = "delivered";
  order5.latitude = -23.56168;
  order5.longitude = -46.656139;
  order5.address = "Avenida Paulista, 1500";
  order5.products = [product4, product7];

  const order6 = new Order();
  order6.status = "pending";
  order6.latitude = -23.56168;
  order6.longitude = -46.656139;
  order6.address = "Avenida Paulista, 1500";
  order6.products = [product1, product5];

  const order7 = new Order();
  order7.status = "pending";
  order7.latitude = -23.56168;
  order7.longitude = -46.656139;
  order7.address = "Avenida Paulista, 1500";
  order7.products = [product5, product7];

  conn.manager.save([order1, order2, order3, order4, order5, order6, order7]);
};
