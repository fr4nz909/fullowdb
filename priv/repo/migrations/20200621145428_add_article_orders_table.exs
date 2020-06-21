defmodule Fullowdb.Repo.Migrations.AddArticleOrdersTable do
  use Ecto.Migration

  def change do
    create table(:article_orders) do
      add :article_id, references(:articles), null: false
      add :user_id, references(:users), null: false

      add :amount, :integer, null: false
      add :discount, :integer

      timestamps()
  end
end
end