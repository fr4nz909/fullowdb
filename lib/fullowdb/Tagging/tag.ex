defmodule Fullowdb.Tagging.Tag do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Tagging.Tag

    schema "tags" do
        field :description
        field :name, :string, null: false

        many_to_many :posts, Fullowdb.Media.Post, join_through: "posts_taggings"
        # FOR MORE TAGGINGS: many_to_many :WHATTOTAG, Fullowdb.WHATTOTAG, join_through: "WHATTOTAG_taggings"

        timestamps()
    end

    @doc false
    def changeset(%Tag{} = tag, attrs) do
        tag
        |> cast(attrs, [:name, :description])
        |> validate_required([:name])
    end
end