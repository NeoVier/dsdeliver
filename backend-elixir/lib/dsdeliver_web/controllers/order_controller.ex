defmodule DsdeliverWeb.OrderController do
  use DsdeliverWeb, :controller

  alias Dsdeliver.Orders
  alias Dsdeliver.Orders.Order

  action_fallback DsdeliverWeb.FallbackController

  def index(conn, _params) do
    orders = Orders.list_orders()
    render(conn, "index.json", orders: orders)
  end

  def create(conn, order_params) do
    with {:ok, %Order{} = order} <- Orders.create_order(order_params) do
      conn
      |> put_status(:created)
      |> render("show.json", order: order)
    end
  end

  def delivered(conn, %{"id" => id}) do
    with {:ok, %Order{}} <- Orders.deliver_order(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
