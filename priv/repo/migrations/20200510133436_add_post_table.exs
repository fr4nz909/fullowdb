defmodule Fullowdb.Repo.Migrations.AddPostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :media_type, :integer
      add :media_url, :string
      add :text, :string
      add :is_premium, :boolean

      timestamps()
    end
  end
end
