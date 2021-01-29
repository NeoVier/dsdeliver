defmodule Dsdeliver.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :float
      add :description, :string
      add :image_uri, :string

      timestamps()
    end

  end
end
