defmodule Fullowdb.Repo.Migrations.CreateSubsMade do
  use Ecto.Migration

  def change do
    create table(:subs_made) do
      add :following_id, references(:followings, on_delete: :nothing), null: false
      add :sub_id, references(:subs, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:subs_made, [:sub_id, :following_id], name: :following_sub)
  end
end
