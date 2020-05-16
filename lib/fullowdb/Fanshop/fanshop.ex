defmodule Fullowdb.Fanshop do
    import Ecto.Query, warn: false
    alias Fullowdb.Repo

    alias Fullowdb.Fanshop.Article
    def list_articles(%{matching: name}) when is_binary(name) do
        Article
        |> where([m], ilike(m.name, ^"%#{name}%"))
        |> Repo.all
    end

    def list_articles(_) do
        Repo.all(Article)
    end
        
end