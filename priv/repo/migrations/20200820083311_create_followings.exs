defmodule Fullowdb.Repo.Migrations.CreateFollowings do
  use Ecto.Migration

  def change do
    create table(:followings) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :follower_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:followings, [:follower_id, :user_id], unique: true)
  end
end
