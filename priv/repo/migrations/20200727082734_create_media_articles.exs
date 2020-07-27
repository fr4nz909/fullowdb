defmodule Fullowdb.Repo.Migrations.CreateMediaArticles do
  use Ecto.Migration

  #add :name, :string, null: false
  #add :description, :string
  #add :price, :float, null: false
  #add :article_media, {:array, :string}, null: false
  #
  #add :user_id, references(:users, on_delete: :delete_all), null: false

  #timestamps()

  def change do
    create table(:media_articles) do
      add :name, :string, null: false
      add :description, :string
      add :price, :float, null: false
      add :article_media, {:array, :string}, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

  end
end
