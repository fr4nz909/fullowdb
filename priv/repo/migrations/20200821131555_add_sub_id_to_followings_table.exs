defmodule Fullowdb.Repo.Migrations.AddSubIdToFollowingsTable do
  use Ecto.Migration

  def change do
    alter table("followings") do
      add :sub_id, references(:subs)
    end
  end
end
