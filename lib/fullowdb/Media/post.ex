defmodule Fullowdb.Media.Post do
    use Ecto.Schema
    @timestamps_opts [type: :utc_datetime]

    @doc  "The list of all available Posts"
    schema "posts" do
        field :is_photo, :boolean
        field :media_url, :string
        field :text, :string
        field :is_premium, :boolean

        timestamps()

        belongs_to :user, Fullowdb.Account.User
  end
end