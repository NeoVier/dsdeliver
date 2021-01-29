defmodule DsdeliverWeb.ProductController do
  use DsdeliverWeb, :controller

  alias Dsdeliver.Products
  alias Dsdeliver.Products.Product

  action_fallback DsdeliverWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      |> render("show.json", product: product)
    end
  end
end
