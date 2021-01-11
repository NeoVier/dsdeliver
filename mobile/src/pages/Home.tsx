import React from "react";
import { Image, StyleSheet, Text, View } from "react-native";
import { RectButton } from "react-native-gesture-handler";

const Home = () => {
  const handlePress = () => {};
  return (
    <>
      <View style={styles.container}>
        <Image source={require("../assets/deliveryman.png")} />
        <Text style={styles.title}>
          Acompanhe os pedidos e entregue no prazo!
        </Text>
        <Text style={styles.description}>
          Receba todos os pedidos do seu restaurante na palma da sua mão
        </Text>
      </View>
      <RectButton style={styles.button} onPress={handlePress}>
        <Text style={styles.buttonText}>VER PEDIDOS</Text>
      </RectButton>
    </>
  );
};

const styles = StyleSheet.create({
  container: {
    marginTop: "15%",
    alignItems: "center",
  },

  title: {
    color: "#263238",
    fontSize: 26,
    lineHeight: 35,
    fontWeight: "bold",
    marginTop: 31,
    marginHorizontal: 15,
    textAlign: "center",
  },

  description: {
    marginTop: 20,
    textAlign: "center",
    color: "#9e9e9e",
    fontSize: 16,
    lineHeight: 22,
    marginHorizontal: 80,
  },

  button: {
    backgroundColor: "#da5c5c",
    alignSelf: "center",
    borderRadius: 10,
    marginTop: 50,
  },

  buttonText: {
    textAlign: "center",
    color: "white",
    paddingVertical: 20,
    paddingHorizontal: 50,
    fontWeight: "bold",
    fontSize: 18,
  },
});

export default Home;
