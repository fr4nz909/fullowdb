defmodule FullowdbWeb.Schema.AccountTypes do
    use Absinthe.Schema.Notation
    alias FullowdbWeb.Resolvers

    object :user_queries do

    @desc  "The list of all available Users"
    field :users, list_of(:user) do
        arg :matching, :string
        arg :order, type: :sort_order, default_value: :asc
        resolve &Resolvers.Account.list_users/3
    end

      #Other Account-related fields

    end

    object :user do
        field :id, :id
        field :username, :string
        field :posts, list_of(:post)
    end
end