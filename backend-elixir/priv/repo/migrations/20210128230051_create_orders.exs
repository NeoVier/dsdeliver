defmodule Dsdeliver.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :address, :string
      add :latitude, :float
      add :longitude, :float
      add :status, :string

      timestamps()
    end

  end
end
