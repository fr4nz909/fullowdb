defmodule FullowdbWeb.Resolvers.Account do
    alias Fullowdb.Account
    
    def list_users(_, args, _) do
        {:ok, Account.list_users(args)}
    end

    def create_user(_, %{input: params}, _) do
        case Account.create_user(params) do
            {:error, changeset} ->
                {
                    :error,
                    message: "could not create user",
                    details: Helpers.error_details(changeset),
                }
                success ->
                success
        end
    end

end