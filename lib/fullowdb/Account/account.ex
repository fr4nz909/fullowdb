defmodule Fullowdb.Account do
    import Ecto.Query, warn: false
    alias Fullowdb.Repo

    alias Fullowdb.Account.User

    def create_user(attrs \\ %{}) do
        %User{}
        |> User.changeset(attrs)
        |> Repo.insert()
    end

    def list_users(filters) do
        filters
        |> Enum.reduce(User, fn
            {_, nil}, query ->
                query
                {:order, order}, query ->
                    from q in query, order_by: {^order, :username}
                {:matching, username}, query ->
                    from q in query, where: ilike(q.username, ^"%#{username}%")
                end)
        |> Repo.all
    end
    
    def list_users(_) do
        Repo.all(User)
    end

    def get_user!(id), do: Repo.get!(User, id)
end