import React from "react";
import { StyleSheet, Text, View } from "react-native";

const OrderCard = () => {
  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.order}>Pedido 1</Text>
        <Text style={styles.price}>R$ 50,00</Text>
      </View>
      <Text style={styles.text}>Há 30 min</Text>
      <View style={styles.productList}>
        <Text style={styles.text}>Pizza Calabresa</Text>
        <Text style={styles.text}>Pizza Quatro Queijos</Text>
        <Text style={styles.text}>Pizza Marguerita</Text>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginHorizontal: "5%",
    marginTop: "10%",
    padding: 15,
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
