defmodule Fullowdb.Account.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Account.User
    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all registered Users"
    schema "users" do
        field :username, :string
        field :first_name, :string
        field :last_name, :string
        field :street_name, :string
        field :street_number, :string
        field :post_code, :string
        field :city, :string
        field :country_code, :integer
        field :date_of_birth, :string
        field :email, :string
        field :password, :string
        
        timestamps()

        has_many :posts, Fullowdb.Media.Post
        has_many :stories, Fullowdb.Media.Story
        has_many :articles, Fullowdb.Media.Article
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :first_name, :last_name, :country_code, :date_of_birth, :email, :password])
    |> validate_required([:username, :date_of_birth, :email, :password])
  end
end