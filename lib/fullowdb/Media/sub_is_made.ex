defmodule Fullowdb.SubIsMade do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.SubIsMade

    import Ecto.Query, warn: false

    alias Fullowdb.{Repo, Sub, Following}
  
    schema "subs_made" do
      belongs_to :following, Following
      belongs_to :sub, Sub
  
      timestamps()
    end

    def sub_is_made(sub_id, following_id) do
      result = sub_made_exists(sub_id, following_id)
  
      if result == nil do
        create_sub_made(%{sub_id: sub_id, following_id: following_id})
        {:ok, true}
      else
        delete_sub_made(result)
        {:ok, false}
      end
    end

    def create_sub_made(attrs \\ %{}) do
      %SubIsMade{}
      |> SubIsMade.changeset(attrs)
      |> Repo.insert()
    end
  
    def delete_sub_made(%SubIsMade{} = sub_is_made) do
      Repo.delete(sub_is_made)
    end
  
    defp sub_made_exists(sub_id, following_id) do
      query = from p in SubIsMade,
      where: p.sub_id == ^sub_id and p.following_id == ^following_id
      Repo.one(query)
    end
  
    @doc false
    def changeset(sub_is_made, attrs) do
      sub_is_made
      |> cast(attrs, [:following_id, :sub_id])
      |> validate_required([:following_id, :sub_id])
    end
  end