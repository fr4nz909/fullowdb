defmodule FullowdbWeb.Schema.UserFollowingTypes do
    use Absinthe.Schema.Notation
  
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  
    alias FullowdbWeb.{Data, Resolvers}
  
    @desc "Following a User on the site"
    object :user_following do
        field :user_followed_id, :user, resolve: dataloader(Data)
    end
  
    object :user_following_queries do
      @desc "Get all followings for a specific User"
      field :user_followings, list_of(:user_following) do
        arg(:user_id, non_null(:id))
        resolve(&Resolvers.UserFollowingResolver.list/3)
      end
    end
  
    object :user_following_mutations do
      @desc "Create UserFollowing"
      field :create_user_following, :user_following do
        arg(:user_followed_id, non_null(:id))
  
        resolve(&Resolvers.UserFollowingResolver.create/3)
      end
    end
  
    object :user_following_subscriptions do
      field :user_following_created, :user_following do
        arg(:user_id, non_null(:id))
  
        config(fn args, _ ->
          {:ok, topic: args.user_followed_id}
        end)
  
        trigger(:create_user_following,
          topic: fn user_following ->
            user_following.user_id
          end
        )
      end
    end
  end