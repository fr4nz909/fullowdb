defmodule Fullowdb.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subs) do
      add :title, :string, null: false
      add :body, :text
      add :price, :float, null: false
      add :period_of_validity, :integer, null: false
      
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :following_id, references(:followings)

      timestamps()
    end

    create index(:subs, [:user_id, :id], unique: true)
  end
end
