defmodule Fullowdb.Repo.Migrations.AddStoryTable do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :is_photo, :boolean
      add :media_url, :string
      add :text, :string
      add :is_premium, :boolean

      timestamps()
    end
  end
end
