defmodule FullowdbWeb.Schema.PostLikeTypes do
    use Absinthe.Schema.Notation
  
    import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  
    alias FullowdbWeb.{Data, Resolvers}
  
    @desc "A post like on the site"
    object :post_like do

      field :post, :post, resolve: dataloader(Data)
      field :user, :user, resolve: dataloader(Data)
    end
  
    object :post_like_queries do
      @desc "Get all post_likes for a specific post"
      field :post_likes, list_of(:post_like) do
        arg(:post_id, non_null(:id))
        
        resolve(&Resolvers.PostLikeResolver.list/3)
      end
    end
  
    object :post_like_mutations do
      @desc "Create or delete post like"
      field :post_like, :boolean do
        arg(:post_id, non_null(:id))
  
        resolve(&Resolvers.PostLikeResolver.post_like/3)
      end
    end
  
    object :post_like_subscriptions do
      field :post_like_created, :boolean do
        arg(:post_id, non_null(:id))
  
        config(fn args, _ ->
          {:ok, topic: args.post_id}
        end)
  
        trigger(:create_post_like,
          topic: fn post_like ->
            post_like.post_id
          end
        )
      end
    end
  end