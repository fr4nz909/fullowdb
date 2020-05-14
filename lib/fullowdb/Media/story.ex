defmodule Fullowdb.Media.Story do
    use Ecto.Schema
    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all available Stories"
    schema "stories" do
        field :is_photo, :boolean
        field :media_url, :string
        field :text, :string
        field :is_premium, :boolean

        timestamps()

        belongs_to :user, Fullowdb.Account.User
  end
end