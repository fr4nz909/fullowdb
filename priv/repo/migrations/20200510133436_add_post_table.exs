defmodule Fullowdb.Repo.Migrations.AddPostTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :media_type, :integer
      add :post_media, {:array, :string}
      add :post_text, :string
      add :is_premium, :boolean

      timestamps()
    end
  end
end
