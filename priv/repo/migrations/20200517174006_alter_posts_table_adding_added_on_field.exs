defmodule Fullowdb.Repo.Migrations.AlterPostsTableAddingAddedOnField do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :added_on, :date
    end
  end
end
