import dayjs from "dayjs";
import "dayjs/locale/pt-br";
import relativeTime from "dayjs/plugin/relativeTime";
import "intl";
import "intl/locale-data/jsonp/pt";
import React from "react";
import { StyleSheet, Text, View } from "react-native";
import { Order } from "../models/Order";

dayjs.locale("pt-br");
dayjs.extend(relativeTime);

type Props = {
  order: Order;
};

const dateFromNow = (date: Date) => dayjs(date).fromNow();

const formatPrice = (price: number) => {
  const formatter = new Intl.NumberFormat("pt-BR", {
    style: "currency",
    currency: "BRL",
    minimumFractionDigits: 2,
  });

  return formatter.format(price);
};

const OrderCard = ({ order }: Props) => {
  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.order}>Pedido {order.id}</Text>
        <Text style={styles.price}>{formatPrice(order.total)}</Text>
      </View>
      <Text style={styles.text}>{dateFromNow(order.moment)}</Text>
      <View style={styles.productList}>
        {order.products.map((product) => (
          <Text key={product.id} style={styles.text}>
            {product.name}
          </Text>
        ))}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginHorizontal: "5%",
    padding: 15,
    marginBottom: 20,
    backgroundColor: "#fff",
    shadowOpacity: 0.25,
    shadowColor: "#f2f2f2",
    shadowOffset: { width: 0, height: 4 },
    shadowRadius: 20,
    elevation: 10,
    borderRadius: 10,
  },

  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    marginBottom: 5,
  },

  order: {
    fontWeight: "bold",
    fontSize: 18,
    color: "#263238",
    textTransform: "uppercase",
  },

  price: {
    fontWeight: "bold",
    fontSize: 18,
    color: "#da5c5c",
  },

  text: {
    fontSize: 14,
    color: "#9e9e9e",
    lineHeight: 19,
  },

  productList: {
    borderTopColor: "#e6e6e6",
    borderTopWidth: 1,
    marginTop: 10,
    paddingVertical: 10,
  },
});

export default OrderCard;
