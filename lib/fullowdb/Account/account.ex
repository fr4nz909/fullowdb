defmodule Fullowdb.Account do
    import Ecto.Query, warn: false
    alias Fullowdb.Repo


    alias Fullowdb.Account.User
    def list_users(%{matching: username}) when is_binary(username) do
        User
        |> where([m], ilike(m.username, ^"%#{username}%"))
        |> Repo.all
    end
    
    def list_users(_) do
        Repo.all(User)
    end
end