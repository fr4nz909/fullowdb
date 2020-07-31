defmodule Fullowdb.Account.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Account.User
    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all registered Users"
    schema "users" do
        field :username, :string, unique: true

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
      :username, :date_of_birth, :email,
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
    IO.inspect changeset
    changeset
  end
end