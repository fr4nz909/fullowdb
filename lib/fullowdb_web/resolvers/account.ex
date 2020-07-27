defmodule FullowdbWeb.Resolvers.Account do
    alias Fullowdb.Account

    def login(_, %{email: email, password: password, role: role}, _) do
        case Accounts.authenticate(role, email, password) do
          {:ok, user} ->
            token = Fullowdb.Authentication.sign(%{
              role: role, id: user.id
            })
            {:ok, %{token: token, user: user}}
          _ ->
            {:error, "incorrect email or password"}
        end
      end
    
    def list_users(_, args, %{context: context}) do
        IO.inspect(context)
        {:ok, Account.list_users(args)}
    end

    #def create_user(_, %{input: params}, _) do
    #    case Account.create_user(params) do
    #        {:error, changeset} ->
    #            {
    #                :error,
    #                message: "could not create user",
    #            }
    #            success ->
    #            success
    #    end
    #end

    def create_user(_, %{input: params}, _) do
      with {:ok, user} <- Account.create_user(params) do
        {:ok, %{user: user}}
      end
    end

    def me(_, _, %{context: %{current_user: current_user}}) do
        {:ok, current_user}
      end
      def me(_, _, _) do
        {:ok, nil}
      end

end