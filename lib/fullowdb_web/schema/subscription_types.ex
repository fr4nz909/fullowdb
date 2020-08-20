defmodule FullowdbWeb.Schema.SubscriptionTypes do
    use Absinthe.Schema.Notation
  
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  
    alias FullowdbWeb.{Data, Resolvers}

    # add :title, :string, null: false
    # add :body, :text
    # add :price, :float, null: false
    # add :period_of_validity, :integer, null: false
  
    @desc "A subscription on the site"
    object :sub do
      field :id, :id
      field :title, non_null(:string)
      field :body, :string
      field :price, non_null(:float)
      field :period_of_validity, non_null(:integer)

      field :user, :user, resolve: dataloader(Data)
      field :followings, list_of(:following), resolve: dataloader(Data)
    end
  
    object :subscription_queries do

        @desc "Get all subscriptions for the current user"
        field :current_user_subscriptions, list_of(:sub) do

            resolve(&Resolvers.SubscriptionResolver.list_for_current_user/3)
        end

        @desc "Get all subscriptions for a specific user"
        field :subscriptions, list_of(:sub) do
        arg(:user_id, non_null(:id))

        resolve(&Resolvers.SubscriptionResolver.list/3)
        end

    end
  
    object :subscription_mutations do
      @desc "Create subscription"
      field :create_subscription, :sub do
        arg(:title, non_null(:string))
        arg(:body, :string)
        arg(:price, non_null(:float))
        arg(:period_of_validity, non_null(:integer))

        resolve(&Resolvers.SubscriptionResolver.create/3)
      end
    end
  
    object :subscription_subscriptions do
      field :subscription_created, :sub do
        arg(:title, non_null(:string))
        arg(:body, :string)
        arg(:price, non_null(:float))
        arg(:period_of_validity, non_null(:integer))
  
        config(fn args, _ ->
          {:ok, topic: args.user_id}
        end)
  
        trigger(:create_subscription,
          topic: fn sub ->
            sub.user_id
          end
        )
      end
    end
  end