defmodule Fullowdb.Media.Post do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Media.Post

    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all available Posts"
    schema "posts" do
        field :is_photo, :boolean
        field :post_media, {:array, :string}
        field :post_text, :string
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
    |> cast(attrs, [:post_text, :post_media, :is_premium, :user_id, :tags])
    |> validate_required([:post_media, :post_text, :is_premium, :user_id])
  end
end