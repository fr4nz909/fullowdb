defmodule Fullowdb.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :username, :string, size: 20
      add :first_name, :string
      add :last_name, :string
      add :street_name, :string
      add :street_number, :string
      add :post_code, :string
      add :city, :string
      add :country_code, :integer
      add :date_of_birth, :string

      add :email, :string
      add :password, :string

      timestamps()
    end
  end
end
