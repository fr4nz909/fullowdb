defmodule Fullowdb.User do
    use Fullowdb.Model
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.{Repo, User, Conversation}
    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all registered Users"
    schema "users" do
        field :username, :string, unique: true

        field :date_of_birth, :string
        field :email, :string

        field :password_hash, :string
        field :password, :string, virtual: true
        field :password_confirmation, :string, virtual: true
        
        timestamps()

        many_to_many :conversations, Conversation, join_through: "conversation_users"

        has_many :posts, Fullowdb.Post
        has_many :followings, Fullowdb.Following
        has_many :stories, Fullowdb.Story
        has_many :articles, Fullowdb.Article
  end

  def search(search_term, current_user) do
      Repo.all(
        from u in __MODULE__,
          where: ilike(u.username, ^("%" <> search_term <> "%")) and u.id != ^current_user.id,
          limit: 25
      )
  end

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [
      :username, :date_of_birth, :email, :password, :password_confirmation
    ])
    |> validate_required([:username, :email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash
  end
end