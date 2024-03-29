defmodule FullowdbWeb.Schema do
  use Absinthe.Schema

  alias FullowdbWeb.Data

  import_types(Absinthe.Type.Custom)
  import_types(FullowdbWeb.Schema.CommentTypes)
  import_types(FullowdbWeb.Schema.ConversationTypes)
  import_types(FullowdbWeb.Schema.MessageTypes)
  import_types(FullowdbWeb.Schema.PostTypes)
  import_types(FullowdbWeb.Schema.UserTypes)
  import_types(FullowdbWeb.Schema.FollowingTypes)
  import_types(FullowdbWeb.Schema.PostLikeTypes)
  import_types(FullowdbWeb.Schema.SubTypes)

  query do
    import_fields(:comment_queries)
    import_fields(:conversation_queries)
    import_fields(:message_queries)
    import_fields(:post_queries)
    import_fields(:user_queries)
    import_fields(:following_queries)
    import_fields(:post_like_queries)
    import_fields(:sub_queries)
  end

  mutation do
    import_fields(:comment_mutations)
    import_fields(:conversation_mutations)
    import_fields(:message_mutations)
    import_fields(:post_mutations)
    import_fields(:user_mutations)
    import_fields(:following_mutations)
    import_fields(:post_like_mutations)
    import_fields(:sub_mutations)
  end

  subscription do
    import_fields(:comment_subscriptions)
    import_fields(:conversation_subscriptions)
    import_fields(:message_subscriptions)
    import_fields(:post_subscriptions)
    import_fields(:following_subscriptions)
    import_fields(:post_like_subscriptions)
    import_fields(:sub_subscriptions)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Data, Data.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, _object) do
    [NewRelic.Absinthe.Middleware] ++ middleware
  end
end