defmodule Fullowdb.Repo.Migrations.CreateLikePhotos do
  use Ecto.Migration

  def change do
    create table(:post_likes) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :post_id, references(:posts, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:post_likes, [:user_id, :post_id], name: :user_likes_post)
  end
end
