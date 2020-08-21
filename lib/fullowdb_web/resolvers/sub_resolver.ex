defmodule FullowdbWeb.Resolvers.SubResolver do
    alias Fullowdb.{Repo, Sub, User}

    # list_for_current_user
    def list_for_current_user(_parent, _args, %{
        context: %{current_user: current_user}
        }) do
        user =
            current_user.id
            |> User.find()
            |> Repo.preload(:subs)
    
        {:ok, user.subs}
    end
  
    def list(_parent, args, _resolutions) do
      user =
        args[:user_id]
        |> User.find()
        |> Repo.preload(:subs)
  
      {:ok, user.subs}
    end

    def create(_parent, args, %{
          context: %{current_user: current_user}
        }) do
      args
      |> Map.put(:user_id, current_user.id)
      |> Sub.create()
      |> case do
        {:ok, sub} ->
          {:ok, sub}
  
        {:error, changeset} ->
          {:error, extract_error_msg(changeset)}
      end
    end
  
    def create(_parent, _args, _resolutions) do
      {:error, "Unauthenticated"}
    end
  
    defp extract_error_msg(changeset) do
      changeset.errors
      |> Enum.map(fn {field, {error, _details}} ->
        [
          field: field,
          message: String.capitalize(error)
        ]
      end)
    end
  end