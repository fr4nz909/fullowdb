defmodule Fullowdb.Schema do
    use Absinthe.Schema

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

      field :search, list_of(:search_result) do
        arg :matching, non_null(:string)
        resolve &Resolvers.Media.search/3
      end

    end

    mutation do
      # Mutation fields for writing into database

      field :create_post, :post do
       arg :input, non_null(:post_input)
       resolve &Resolvers.Media.create_post/3 
      end

      field :create_story, :story do
        arg :input, non_null(:story_input)
        resolve &Resolvers.Media.create_story/3 
       end

       field :create_article, :article do
        arg :input, non_null(:article_input)
        resolve &Resolvers.Fanshop.create_article/3 
       end
    end

    object :post_result do
        field :post, :post
        field :erros, list_of(:input_error)
    end

    @desc "An error encountered trying to persist input"
    object :input_error do
      field :key, non_null(:string)
      field :message, non_null(:string)
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