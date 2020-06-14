defmodule FullowdbWeb.Resolvers.Fanshop do
    alias Fullowdb.Fanshop
    alias FullowdbWeb.Resolvers
    
    def list_articles(_, args, _) do
        {:ok, Fanshop.list_articles(args)}
    end

    def create_article(_, %{input: params}, _) do
        case Fanshop.create_article(params) do
        {:error, changeset} ->
            {
                :error,
                message: "could not create article",
                details: Helpers.error_details(changeset),
            }
            success ->
            success
        end
    end
end