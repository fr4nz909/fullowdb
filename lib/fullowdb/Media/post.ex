defmodule Fullowdb.Media.Post do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Media.Post

    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all available Posts"
    schema "posts" do
        field :is_photo, :boolean
        field :media_url, :string
        field :text, :string
        field :is_premium, :boolean
        field :added_on, :date

        timestamps()

        belongs_to :user, Fullowdb.Account.User

        many_to_many :tags, Fullowdb.Tagging.Tag,
          join_through: "posts_taggings"
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:text, :media_url, :is_premium])
    |> validate_required([:text, :is_premium, :media_url])
  end
end