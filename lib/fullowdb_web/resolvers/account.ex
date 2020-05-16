defmodule Fullowdb.Resolvers.Account do
    alias Fullowdb.Account
    
    def list_users(_, args, _) do
        {:ok, Account.list_users(args)}
    end
end