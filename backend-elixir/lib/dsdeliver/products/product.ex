defmodule Dsdeliver.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :image_uri, :string
    field :name, :string
    field :price, :float
    many_to_many :orders, Dsdeliver.Orders.Order, join_through: "orders_products"

    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :description, :image_uri])
    |> validate_required([:name, :price, :description, :image_uri])
  end
end
