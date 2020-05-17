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
        arg :order, type: :sort_order, default_value: :asc
        resolve &Resolvers.Account.list_users/3
      end

        @desc  "The list of all available Posts"
        field :posts, list_of(:post) do
          arg :filter, :post_filter
          arg :matching, :string
          arg :order, type: :sort_order, default_value: :asc
          resolve &Resolvers.Media.list_posts/3
      end

        @desc "The list of all available Articles"
        field :articles, list_of(:article) do
          arg :filter, :article_filter
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

    enum :sort_order do
      value :asc
      value :desc
    end

    @desc "Filtering options for the articles list"
    input_object :article_filter do
      @desc "Matching a Name"
      field :username, :string

      @desc "Matching a Tag"
      field :tag, :string

      @desc "Priced above a Value"
      field :priced_above, :float

      @desc "Priced below a Value"
      field :priced_below, :float

    end

    @desc "Filtering options for the post list"
    input_object :post_filter do
      @desc "Matching a Text"
      field :text, :string

      @desc "Matching a Tag"
      field :tag, :string

    end

end