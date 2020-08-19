defmodule Fullowdb.Repo.Migrations.AddPostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :post_media, {:array, :string}
      add :body, :string
      add :price, :float, default: 0.0, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:posts, [:user_id])
  end
end
