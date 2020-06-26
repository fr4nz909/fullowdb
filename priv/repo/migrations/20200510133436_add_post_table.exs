defmodule Fullowdb.Repo.Migrations.AddPostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :post_media, {:array, :string}
      add :post_text, :string
      add :is_premium, :boolean, default: false, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
