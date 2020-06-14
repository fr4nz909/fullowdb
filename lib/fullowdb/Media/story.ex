defmodule Fullowdb.Media.Story do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Media.Story

    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all available Stories hehe"
    schema "stories" do
        field :is_photo, :boolean
        field :media_url, :string
        field :text, :string
        field :is_premium, :boolean

        timestamps()

        belongs_to :user, Fullowdb.Account.User
  end

    @doc false
    def changeset(%Story{} = story, attrs) do
      story
      |> cast(attrs, [:text, :media_url, :is_premium])
      |> validate_required([:text])
    end
end