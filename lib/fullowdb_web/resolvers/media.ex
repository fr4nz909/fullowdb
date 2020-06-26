defmodule FullowdbWeb.Resolvers.Media do
    alias Fullowdb.Media
    alias FullowdbWeb.Resolvers
    
    def list_posts(%Fullowdb.Account.User{} = user, args, _resolution) do
        {:ok, Media.list_posts(user, args)}
    end

    def list_posts(_, args, _) do
        {:ok, Media.list_posts(args)}
    end

    def posts_for_tag(tag, _, _) do
        query = Ecto.assoc(tag, :posts)
        {:ok, Fullowdb.Repo.all(query)}
    end

    def search(_, %{matching: term}, _) do
        {:ok, Media.search(term)}
    end

    def create_post(_, %{input: params}, _) do
        with {:ok, post} <- Media.create_post(params) do
            {:ok, %{post: post}}
        end
    end

    def create_story(_, %{input: params}, _) do
        case Media.create_story(params) do
        {:error, _} ->
            {:error, "Could not create Post"}
        {:ok, _} = success ->
            success
        end
    end
end