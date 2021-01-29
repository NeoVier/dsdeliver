defmodule DsdeliverWeb.Router do
  use DsdeliverWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DsdeliverWeb do
    pipe_through :api

    resources "/products", ProductController, only: [:index]
    resources "/orders", OrderController, only: [:index, :create]
    put "/orders/:id/delivered", OrderController, :delivered
  end
end
