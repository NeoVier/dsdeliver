defmodule DsdeliverWeb.OrderView do
  use DsdeliverWeb, :view
  alias DsdeliverWeb.OrderView

  def render("index.json", %{orders: orders}) do
    render_many(orders, OrderView, "order.json")
  end

  def render("show.json", %{order: order}) do
    render_one(order, OrderView, "order.json")
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      address: order.address,
      latitude: order.latitude,
      longitude: order.longitude,
      moment: order.inserted_at,
      status: order.status
    }
  end
end
