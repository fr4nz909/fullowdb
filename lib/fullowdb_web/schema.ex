defmodule Fullowdb.Schema do
    use Absinthe.Schema
    import Ecto.Query

    alias Fullowdb.{Repo, Account.User, Media.Post, Media.Story, Fanshop.Article}
    alias FullowdbWeb.Resolvers

    import_types FullowdbWeb.Schema.AccountTypes
    import_types FullowdbWeb.Schema.MediaTypes
    import_types FullowdbWeb.Schema.FanshopTypes

    @desc  "The entrypoint to all Queries"
    
    query do

      import_fields :post_queries
      import_fields :user_queries
      import_fields :article_queries

    end

    enum :sort_order do
      value :asc
      value :desc
    end

    scalar :date do
      parse fn input ->
        #Parsing the input
        case Date.from_iso8601(input.value) do
          {:ok, date} -> {:ok, date}
          _ -> :error
        end
    end

    serialize fn date ->
      # Serializing logic for output after elixir processing
      Date.to_iso8601(date)
    end
  end

end