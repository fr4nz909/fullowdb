defmodule Fullowdb.Repo.Migrations.AddArticleOrdersTable do
  use Ecto.Migration

  def change do
    create table(:article_orders) do
      add :user_id, references(:users), null: false
      add :items, :map

      add :ordered_at, :utc_datetime, null: false, default: fragment("NOW()")
      add :state, :string, null: false, default: "created"

      timestamps()
  end
end
end