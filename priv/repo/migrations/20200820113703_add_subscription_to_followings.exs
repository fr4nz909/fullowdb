defmodule Fullowdb.Repo.Migrations.AddSubscriptionToFollowings do
  use Ecto.Migration

  def change do
    alter table("followings") do
      add :subscription_id, references(:subscriptions, on_delete: :delete_all)
    end
  end
end
