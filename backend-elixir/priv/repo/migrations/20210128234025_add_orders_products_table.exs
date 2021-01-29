defmodule Dsdeliver.Repo.Migrations.AddOrdersProductsTable do
  use Ecto.Migration

  def change do
    create table(:orders_products) do
      add :order_id, references(:orders)
      add :product_id, references(:products)
    end
  end
end
