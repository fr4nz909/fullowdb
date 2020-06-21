defmodule Fullowdb.Account.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Account.User
    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all registered Users"
    schema "users" do
        field :username, :string, unique: true

        field :first_name, :string
        field :last_name, :string
        field :street_name, :string
        field :street_number, :string
        field :post_code, :string
        field :city, :string
        field :country_code, :integer
        field :date_of_birth, :string
        field :email, :string

        field :role, :string, default: "user"

        field :password_hash, :string
        field :password, :string, virtual: true
        field :password_confirmation, :string, virtual: true
        
        timestamps()

        has_many :posts, Fullowdb.Media.Post
        has_many :stories, Fullowdb.Media.Story
        has_many :articles, Fullowdb.Fanshop.Article
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [
      :username, :first_name, :last_name, :street_name, :street_number,
      :post_code, :city, :country_code, :date_of_birth, :email,
      :role, :password, :password_confirmation
    ])
    |> validate_required([:username, :date_of_birth, :email, :role, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> hash_password
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  defp hash_password(changeset) do
    changeset
  end
end