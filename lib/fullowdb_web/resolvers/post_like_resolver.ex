defmodule FullowdbWeb.Resolvers.PostLikeResolver do
    alias Fullowdb.{Repo, PostLike, Post}
  
    def list(_parent, args, _resolutions) do
      post =
        args[:post_id]
        |> Post.find()
        |> Repo.preload(:post_likes)
  
      {:ok, post.post_likes}
    end

    def post_like(_, %{post_id: post_id}, %{context: %{current_user: current_user}}) do
        with {:ok, message} <- PostLike.post_like(post_id, current_user.id) do
            {:ok, message}
        end
    end
  
    def post_like(_parent, _args, _resolutions) do
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