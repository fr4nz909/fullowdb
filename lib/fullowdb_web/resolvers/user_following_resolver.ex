defmodule FullowdbWeb.UserFollowingResolver do
    alias Fullowdb.UserFollowing
  
    def create(_parent, args, %{context: %{current_user: current_user}}) do
      args
      |> Map.put(:user_id, current_user.id)
      |> UserFollowing.create()
      |> case do
      {:ok, user_following} ->
        {:ok, user_following}

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