defmodule Fullowdb.Fanshop.Article do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Fanshop.Article
    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all available Articles in the Fanshop"
    schema "articles" do
        field :name, :string
        field :description, :string
        field :price, :float
        field :article_media, {:array, :string}

        timestamps()

        belongs_to :user, Fullowdb.Account.User
  end

    @doc false
    def changeset(%Article{} = article, attrs) do
      article
      |> cast(attrs, [:name, :description, :price, :article_media])
      |> validate_required([:name, :description, :price, :article_media])
      |> foreign_key_constraint(:user)
    end
end