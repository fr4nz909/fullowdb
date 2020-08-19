defmodule Fullowdb.Post do
  use Fullowdb.Model

  alias Fullowdb.{Repo, Comment, User}

  schema "posts" do
    field :body, :string
    field :post_media, {:array, :string}

    field :price, :float

    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  def all do
    Repo.all(from row in __MODULE__, order_by: [desc: row.id])
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :post_media, :user_id, :price])    
    |> validate_required([:body, :post_media, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end