defmodule Fullowdb.Schema do
    use Absinthe.Schema
    import Ecto.Query

    alias Fullowdb.{Repo, Account.User, Media.Post, Media.Story, Fanshop.Article}
    alias Fullowdb.Resolvers

    @desc  "The entrypoint to all Queries"
    
    query do
  
      @desc  "The list of all available Users"
      field :users, list_of(:user) do
        arg :matching, :string
        resolve &Resolvers.Account.list_users/3
      end

        @desc  "The list of all available Posts"
        field :posts, list_of(:post) do
          arg :matching, :string
          resolve &Resolvers.Media.list_posts/3
      end

        @desc "The list of all available Articles"
        field :articles, list_of(:article) do
          arg :matching, :string
          resolve &Resolvers.Fanshop.list_articles/3
        end
    end

    object :user do
        field :id, :id
        field :username, :string
    end

    object :post do
        field :id, :id
        field :text, :string
    end

    object :story do
        field :id, :id
        field :text, :string
    end

    object :article do
        field :id, :id
        field :name, :string
        field :price, :float
    end

end