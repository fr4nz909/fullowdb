defmodule Fullowdb.Repo.Migrations.ChangePostsTableMediaTypeField do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :is_photo, :boolean
    end
  end
end
