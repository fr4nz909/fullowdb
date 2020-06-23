defmodule FullowdbWeb.Schema.Types.AccountTypes do
    use Absinthe.Schema.Notation
    alias FullowdbWeb.Resolvers
    alias FullowdbWeb.Schema.Middleware

    object :user_queries do

    @desc  "The list of all available Users"
        field :users, list_of(:user) do
            arg :matching, :string
            arg :order, type: :sort_order, default_value: :asc
            middleware(Middleware.Authorize, :any)
            resolve &Resolvers.Account.list_users/3
    end

      #Other Account-related fields

    end

    object :user do
        field :id, :id
        field :username, :string
        field :email, :string
        field :date_of_birth, :string
        #field :posts, list_of(:post)
    end

    input_object :user_input do
        field :username, non_null(:string)
        field :email, non_null(:string)
        field :date_of_birth, non_null(:string)
        field :password, non_null(:string)
        field :password_confirmation, non_null(:string)
    end
end