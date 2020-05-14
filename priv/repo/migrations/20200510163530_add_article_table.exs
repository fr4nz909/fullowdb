defmodule Fullowdb.Repo.Migrations.AddArticleTable do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :name, :string, null: false
      add :description, :string
      add :price, :decimal, null: false
      add :media_url, :string

      timestamps()
    end
  end
end
