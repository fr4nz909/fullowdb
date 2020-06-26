defmodule Fullowdb.Repo.Migrations.AddStoryTable do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :is_photo, :boolean
      add :story_media, :string, null: false
      add :story_text, :string
      add :is_premium, :boolean, default: false, null: false

      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
