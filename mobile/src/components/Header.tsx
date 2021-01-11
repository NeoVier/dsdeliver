import { useNavigation } from "@react-navigation/native";
import React from "react";
import { Image, StyleSheet, Text, View } from "react-native";
import { TouchableWithoutFeedback } from "react-native-gesture-handler";

const Header = () => {
  const navigation = useNavigation();

  const handlePress = () => {
    navigation.navigate("Home");
  };

  return (
    <TouchableWithoutFeedback onPress={handlePress}>
      <View style={styles.container}>
        <Image source={require("../assets/logo.png")} />
        <Text style={styles.text}>DS Deliver</Text>
      </View>
    </TouchableWithoutFeedback>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: "#da5c5c",
    height: 90,
    paddingTop: 40,
    flexDirection: "row",
    justifyContent: "center",
  },

  text: {
    color: "white",
    fontWeight: "bold",
    fontSize: 18,
    lineHeight: 25,
    letterSpacing: -0.24,
    marginLeft: 15,
    fontFamily: "OpenSans_700Bold",
  },
});

export default Header;
