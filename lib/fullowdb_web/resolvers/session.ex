defmodule FullowdbWeb.Resolvers.Session do
    alias Fullowdb.{Account, Guardian}

    def login_user(_, %{input: input}, _) do
        # check if user is in database
        # if user is registered, return JWT token and the user

        with {:ok, user} <- Account.Session.authenticate(input), {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
            {:ok, %{token: jwt_token, user: user}} 
        end
    end
end