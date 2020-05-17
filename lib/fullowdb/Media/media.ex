defmodule Fullowdb.Media do
    import Ecto.Query, warn: false
    alias Fullowdb.Repo


    alias Fullowdb.Media.Post
    def list_posts(args) do
        args
        |> Enum.reduce(Post, fn
            {:order, order}, query ->
                query |> order_by({^order, :text})
                {:filter, filter}, query ->
                    query |> filter_with(filter)
                end)
        |> Repo.all
    end

    def list_posts(_) do
        Repo.all(Post)
    end

    defp filter_with(query, filter) do
        Enum.reduce(filter, query, fn
            {:text, text}, query ->
                from q in query, where: ilike(q.text, ^"%#{text}%")
            {:tag, tag_name}, query ->
                from q in query, join: t in assoc(q, :tags),
                where: ilike(t.name, ^"%#{tag_name}%")
            end)
    end
end