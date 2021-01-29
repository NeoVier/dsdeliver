defmodule Dsdeliver.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:address, :latitude, :longitude, :status]

  schema "orders" do
    field :address, :string
    field :latitude, :float
    field :longitude, :float
    field :status, :string, default: "pending"
    many_to_many :products, Dsdeliver.Products.Product, join_through: "orders_products"

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:address, :latitude, :longitude, :status])
    |> put_status()
    |> validate_required(@required_fields)
  end

  def put_status(%{changes: %{status: _}} = changeset), do: changeset

  def put_status(changeset) do
    changeset
    |> put_change(:status, "pending")
  end

  def changeset_update_products(%{} = order, products) do
    order
    |> cast(%{}, @required_fields)
    |> put_assoc(:products, products)
  end
end
