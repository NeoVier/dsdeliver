#!/bin/sh

touch ./.env
source ./.env

echo "module Backend.Env

[<Literal>]
let BackendUrl = \"$BACKEND_URL\"" > Env.fs