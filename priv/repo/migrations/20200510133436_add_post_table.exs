defmodule Fullowdb.Repo.Migrations.AddPostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :post_media, {:array, :string}
      add :post_text, :string
      add :is_premium, :boolean

      add :user_id, references(:users)

      timestamps()
    end
  end
end
