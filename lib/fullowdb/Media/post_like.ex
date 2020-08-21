defmodule Fullowdb.PostLike do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.PostLike

    import Ecto.Query, warn: false

    alias Fullowdb.{Repo, Post, User}
  
    schema "post_likes" do
      belongs_to :user, User
      belongs_to :post, Post
  
      timestamps()
    end

    def post_like(post_id, user_id) do
      result = post_like_exists(post_id, user_id)
  
      if result == nil do
        create_post_like(%{post_id: post_id, user_id: user_id})
        {:ok, true}
      else
        delete_post_like(result)
        {:ok, false}
      end
    end

    def create_post_like(attrs \\ %{}) do
      %PostLike{}
      |> PostLike.changeset(attrs)
      |> Repo.insert()
    end
  
    def delete_post_like(%PostLike{} = post_like) do
      Repo.delete(post_like)
    end
  
    defp post_like_exists(post_id, user_id) do
      query = from p in PostLike,
      where: p.post_id == ^post_id and p.user_id == ^user_id
      Repo.one(query)
    end
  
    @doc false
    def changeset(post_like, attrs) do
      post_like
      |> cast(attrs, [:user_id, :post_id])
      |> validate_required([:user_id, :post_id])
    end
  end