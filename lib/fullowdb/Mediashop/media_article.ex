defmodule Fullowdb.Mediashop.MediaArticle do
  use Ecto.Schema
  import Ecto.Changeset

  #add :name, :string, null: false
  #add :description, :string
  #add :price, :float, null: false
  #add :article_media, {:array, :string}, null: false
  #
  #add :user_id, references(:users, on_delete: :delete_all), null: false

  #timestamps()

  schema "media_articles" do
    field :name, :string
    field :description, :string
    field :price, :float
    field :article_media, {:array, :string}

    belongs_to :user, Fullowdb.Account.User

    timestamps()
  end

  @doc false
  def changeset(media_article, attrs) do
    media_article
    |> cast(attrs, [:name, :description, :price, :user_id])
    |> validate_required([:name, :price, :user_id])
  end
end
