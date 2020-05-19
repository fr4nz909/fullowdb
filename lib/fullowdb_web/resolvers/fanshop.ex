defmodule FullowdbWeb.Resolvers.Fanshop do
    alias Fullowdb.Fanshop
    
    def list_articles(_, args, _) do
        {:ok, Fanshop.list_articles(args)}
    end
end