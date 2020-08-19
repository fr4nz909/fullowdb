defmodule Fullowdb.Repo.Migrations.AddArticleTable do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :name, :string, null: false
      add :description, :string
      add :price, :float, null: false
      add :article_media, {:array, :string}, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:articles, [:user_id])
  end
end
