import React from "react";
import { ScrollView, StyleSheet } from "react-native";
import Header from "../components/Header";
import OrderCard from "../components/OrderCard";

const Orders = () => {
  return (
    <>
      <Header />
      <ScrollView
        style={styles.container}
        contentContainerStyle={{ paddingBottom: 30 }}
      >
        <OrderCard />
        <OrderCard />
        <OrderCard />
        <OrderCard />
        <OrderCard />
      </ScrollView>
    </>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingBottom: 100,
  },
});

export default Orders;
