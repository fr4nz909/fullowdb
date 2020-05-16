defmodule Fullowdb.Repo.Migrations.AddTagsTable do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string, null: false
      add :description, :string

      timestamps()
    end
  end
end
