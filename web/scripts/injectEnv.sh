#!/bin/sh

source ./.env

echo "export const MAPBOX_API_KEY=\"$MAPBOX_API_KEY\"" > .env.js
echo "module Env exposing (..)


mapboxApiKey : String
mapboxApiKey =
    \"$MAPBOX_API_KEY\"
" > src/Env.elm