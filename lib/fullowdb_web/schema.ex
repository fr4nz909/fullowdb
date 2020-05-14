defmodule Fullowdb.Schema do
    use Absinthe.Schema

    alias Fullowdb.{Repo, Account.User, Media.Post, Media.Story, Fanshop.Article}

    @desc  "The entrypoint to all Queries"
    query do
  
      @desc  "The list of all available Users"
        field :users, list_of(:user) do
          resolve fn _, _, _ ->
            {:ok, Repo.all(User)}
          end
        end

        @desc  "The list of all available Posts"
        field :posts, list_of(:post) do
          resolve fn _, _, _ ->
            {:ok, Repo.all(Post)}
          end
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