defmodule Fullowdb.Fanshop do
    import Ecto.Query, warn: false
    alias Fullowdb.Repo

    alias Fullowdb.Fanshop.Article
    def list_articles(args) do
        args
        |> Enum.reduce(Article, fn
            {:order, order}, query ->
                query |> order_by({^order, :name})
                {:filter, filter}, query ->
                    query |> filter_with(filter)
                end)
        |> Repo.all
    end

    def list_articles(_) do
        Repo.all(Article)
    end

    defp filter_with(query, filter) do
        Enum.reduce(filter, query, fn
            {:name, name}, query ->
                from q in query, where: ilike(q.name, ^"%#{name}%")
            {:priced_above, price}, query ->
                from q in query, where: q.price >= ^price
            {:priced_below, price}, query ->
                from q in query, where: q.price <= ^price
            {:tag, tag_name}, query ->
                from q in query, join: t in assoc(q, :tags),
                where: ilike(t.name, ^"%#{tag_name}%")
            end)
    end
        
end