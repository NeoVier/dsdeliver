import {
  OpenSans_400Regular,
  OpenSans_700Bold,
} from "@expo-google-fonts/open-sans";
import AppLoading from "expo-app-loading";
import { useFonts } from "expo-font";
import { StatusBar } from "expo-status-bar";
import React from "react";
import { StyleSheet, View } from "react-native";
import Routes from "./src/Routes";

export default function App() {
  let [fontsUsed] = useFonts({
    OpenSans_400Regular,
    OpenSans_700Bold,
  });

  if (!fontsUsed) {
    return <AppLoading />;
  }

  return (
    <View style={styles.container}>
      <StatusBar style="light" />
      <Routes />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
