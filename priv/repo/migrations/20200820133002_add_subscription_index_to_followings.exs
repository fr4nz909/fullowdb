defmodule Fullowdb.Repo.Migrations.AddSubscriptionIndexToFollowings do
  use Ecto.Migration

  def change do
    create index(:followings, [:subscription_id], unique: true)
    create index(:followings, [:user_id, :follower_id, :subscription_id], unique: true)
  end
end
