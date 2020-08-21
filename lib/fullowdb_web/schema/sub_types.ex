defmodule FullowdbWeb.Schema.SubTypes do
    use Absinthe.Schema.Notation
  
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  
    alias FullowdbWeb.{Data, Resolvers}

    #add :title, :string, null: false
    #add :body, :text
    #add :price, :float, null: false
    #add :period_of_validity, :integer, null: false
    #
    #add :user_id, references(:users, on_delete: :delete_all), null: false
    #add :following_id, references(:followings)
  
    @desc "A sub on the site"
    object :sub do
        field :id, :id
        field :title, :string
        field :body, :string
        field :price, :float
        field :period_of_validity, :integer

        field :user, :user, resolve: dataloader(Data)
        field :followings, list_of(:following), resolve: dataloader(Data)
    end
  
    object :sub_queries do

        @desc "Get all subs for the current user"
        field :current_user_subs, list_of(:sub) do

            resolve(&Resolvers.FollowingResolver.list_for_current_user/3)
        end

        @desc "Get all subs for a specific user"
        field :subs, list_of(:sub) do
        arg(:user_id, non_null(:id))

        resolve(&Resolvers.SubResolver.list/3)
        end

    end
  
    object :sub_mutations do
      @desc "Create sub"
      field :create_sub, :sub do
        arg(:title, non_null(:string))
        arg(:body,:string)
        arg(:price,non_null(:float))
        arg(:period_of_validity,non_null(:integer))

        resolve(&Resolvers.SubResolver.create/3)
      end
    end
  
    object :sub_subscriptions do
      field :sub_created, :sub do
        arg(:user_id, non_null(:id))
  
        config(fn args, _ ->
          {:ok, topic: args.user_id}
        end)
  
        trigger(:create_sub,
          topic: fn sub ->
            sub.user_id
          end
        )
      end
    end
  end