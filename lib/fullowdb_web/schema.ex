defmodule Fullowdb.Schema do
    use Absinthe.Schema

    alias Fullowdb.{Repo, Account.User, Media.Post, Media.Story, Fanshop.Article}
    alias FullowdbWeb.Resolvers

    alias FullowdbWeb.Schema.Middleware

    import_types(FullowdbWeb.Schema.Types)

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

      @desc "Register a new user"
      field :create_user, type: :user do
        arg :input, non_null(:user_input)
        resolve &Resolvers.Account.create_user/3
      end

      @desc "Login a user and return a JWT token"
      field :login_user, type: :session do
        arg :input, non_null(:session_input)
        resolve &Resolvers.Session.login_user/3
      end

      @desc "Create a new post"
      field :create_post, type: :post do
       arg :input, non_null(:post_input)
       resolve &Resolvers.Media.create_post/3
       middleware Middleware.ChangesetErrors
      end

      @desc "Create a new story"
      field :create_story, type: :story do
        arg :input, non_null(:story_input)
        resolve &Resolvers.Media.create_story/3 
       end

       @desc "Create a new article"
       field :create_article, type: :article do
        arg :input, non_null(:article_input)
        resolve &Resolvers.Fanshop.create_article/3 
       end
    end

    object :post_result do
        field :post, :post
        field :errors, list_of(:input_error)
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