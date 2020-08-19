defmodule Fullowdb.Repo.Migrations.CreateUserFollowings do
  use Ecto.Migration

  def change do
    create table(:user_followings) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :user_followed_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:user_followings, [:user_followed_id, :user_following_id], name: :user_following)
  end
end
