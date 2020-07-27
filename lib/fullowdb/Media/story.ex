defmodule Fullowdb.Media.Story do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Media.Story

    @timestamps_opts [type: :utc_datetime]

    #add :is_photo, :boolean
    #add :story_media, :string, null: false
    #add :story_text, :string
    #add :is_premium, :boolean, default: false, null: false
    #
    #add :user_id, references(:users, on_delete: :delete_all), null: false

    @doc  "The list of all available Stories hehe"
    schema "stories" do
        field :is_photo, :boolean
        field :story_media, :string
        field :story_text, :string

        timestamps()

        belongs_to :user, Fullowdb.Account.User
  end

    @doc false
    def changeset(%Story{} = story, attrs) do
      story
      |> cast(attrs, [:story_text, :story_media, :user_id])
      |> validate_required([:story_media, :user_id])
    end
end