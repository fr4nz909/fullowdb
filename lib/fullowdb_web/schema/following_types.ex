defmodule FullowdbWeb.Schema.FollowingTypes do
    use Absinthe.Schema.Notation
  
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  
    alias FullowdbWeb.{Data, Resolvers}
  
    @desc "A following on the site"
    object :following do
      field :user, :user, resolve: dataloader(Data)
      field :follower, :user, resolve: dataloader(Data)
    end
  
    object :following_queries do

        @desc "Get all followings for the current user"
        field :current_user_followings, list_of(:following) do

            resolve(&Resolvers.FollowingResolver.list_for_current_user/3)
        end

        @desc "Get all followings for a specific user"
        field :followings, list_of(:following) do
        arg(:user_id, non_null(:id))

        resolve(&Resolvers.FollowingResolver.list/3)
        end

    end
  
    object :following_mutations do
      @desc "Create following"
      field :create_following, :following do
        arg(:user_id, non_null(:id))
        arg(:sub_id, :id)

        resolve(&Resolvers.FollowingResolver.create/3)
      end
    end
  
    object :following_subscriptions do
      field :following_created, :following do
        arg(:user_id, non_null(:id))
  
        config(fn args, _ ->
          {:ok, topic: args.user_id}
        end)
  
        trigger(:create_following,
          topic: fn following ->
            following.user_id
          end
        )
      end
    end
  end