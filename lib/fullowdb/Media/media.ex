defmodule Fullowdb.Media do
    import Ecto.Query, warn: false
    alias Fullowdb.Repo


    alias Fullowdb.Media.Post
    def list_posts(filters) do
        filters
        |> Enum.reduce(Post, fn
            {_, nil}, query ->
                query
                {:order, order}, query ->
                from q in query, order_by: {^order, :text}
                {:matching, text}, query ->
                    from q in query, where: ilike(q.text, ^"%#{text}%")
                end)
        |> Repo.all
    end

    def list_posts(_) do
        Repo.all(Post)
    end
end