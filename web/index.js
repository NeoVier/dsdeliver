import { registerCustomElement, registerPorts } from "elm-mapbox";
import { MAPBOX_API_KEY } from "./.env.js";
import { Elm } from "./src/Main.elm";

registerCustomElement({ token: MAPBOX_API_KEY });

const app = Elm.Main.init({
  node: document.getElementById("main"),
  flags: {
    width: window.innerWidth,
    height: window.innerHeight,
  },
});

registerPorts(app);
