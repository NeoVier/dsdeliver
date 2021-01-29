defmodule DsdeliverWeb.ProductView do
  use DsdeliverWeb, :view
  alias DsdeliverWeb.ProductView

  def render("index.json", %{products: products}) do
    render_many(products, ProductView, "product.json")
  end

  def render("show.json", %{product: product}) do
    render_one(product, ProductView, "product.json")
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description,
      imageUri: product.image_uri
    }
  end
end
