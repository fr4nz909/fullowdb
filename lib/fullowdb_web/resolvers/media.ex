defmodule FullowdbWeb.Resolvers.Media do
    alias Fullowdb.Media
    
    def list_posts(_, args, _) do
        {:ok, Media.list_posts(args)}
    end
end