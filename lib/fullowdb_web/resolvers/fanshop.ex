defmodule FullowdbWeb.Resolvers.Fanshop do
    alias Fullowdb.Fanshop
    
    def list_articles(_, args, _) do
        {:ok, Fanshop.list_articles(args)}
    end

    def create_article(_, %{input: params}, _) do
        with {:ok, article} <- Fanshop.create_article(params) do
            {:ok, %{article: article}}
        end
    end
end