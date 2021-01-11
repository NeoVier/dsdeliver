import { useNavigation } from "@react-navigation/native";
import React from "react";
import { Alert, Linking, StyleSheet, Text, View } from "react-native";
import { RectButton } from "react-native-gesture-handler";
import { confirmDelivered } from "../api";
import Header from "../components/Header";
import OrderCard from "../components/OrderCard";
import { Order } from "../models/Order";

type Props = {
  route: {
    params: {
      order: Order;
    };
  };
};

const OrderDetails = ({ route }: Props) => {
  const { order } = route.params;
  const navigation = useNavigation();

  const googleMapsUrl = ({
    latitude,
    longitude,
  }: {
    latitude: number;
    longitude: number;
  }) => {
    const BASE_URL =
      "https://www.google.com/maps/dir/?api=1&travelmode=driving&dir_action=navigate&destination=";
    return `${BASE_URL}${latitude},${longitude}`;
  };

  const handleTrack = () => {
    Linking.openURL(
      googleMapsUrl({ latitude: order.latitude, longitude: order.longitude })
    );
  };

  const handleConfirmDelivered = () => {
    confirmDelivered(order.id)
      .then(() => {
        Alert.alert("Pedido confirmado com sucesso");
        navigation.navigate("Orders");
      })
      .catch(() => {
        Alert.alert("Houve um erro ao confirmar o pedido");
      });
  };

  const handleCancel = () => {
    navigation.navigate("Orders");
  };

  return (
    <>
      <Header />
      <View style={styles.container}>
        <OrderCard order={order} />

        <RectButton style={styles.button} onPress={handleTrack}>
          <Text style={styles.buttonText}>Iniciar navegação</Text>
        </RectButton>

        <RectButton style={styles.button} onPress={handleConfirmDelivered}>
          <Text style={styles.buttonText}>Confirmar entrega</Text>
        </RectButton>

        <RectButton style={styles.button} onPress={handleCancel}>
          <Text style={styles.buttonText}>Cancelar</Text>
        </RectButton>
      </View>
    </>
  );
};

const styles = StyleSheet.create({
  container: {
    paddingTop: 20,
  },

  button: {
    backgroundColor: "#da5c5c",
    borderRadius: 10,
    marginHorizontal: "5%",
    paddingVertical: 15,
    marginVertical: 20,
  },

  buttonText: {
    textAlign: "center",
    color: "#fff",
    fontWeight: "bold",
    fontSize: 18,
    lineHeight: 25,
    textTransform: "uppercase",
  },
});

export default OrderDetails;
