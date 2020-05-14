defmodule Fullowdb.Repo.Migrations.StoryBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:stories) do
      add :user_id, references(:users)
    end
  end
end
