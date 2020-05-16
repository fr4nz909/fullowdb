defmodule Fullowdb.Media do
    import Ecto.Query, warn: false
    alias Fullowdb.Repo


    alias Fullowdb.Media.Post
    def list_posts(%{matching: text}) when is_binary(text) do
        Post
        |> where([m], ilike(m.text, ^"%#{text}%"))
        |> Repo.all
    end

    def list_posts(_) do
        Repo.all(Post)
    end
end