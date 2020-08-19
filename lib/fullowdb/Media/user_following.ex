defmodule Fullowdb.UserFollowing do
    use Fullowdb.Model
  
    alias Fullowdb.{User}

    # add :user_followed_id, references(:users, on_delete: :delete_all), null: false
    # add :user_following_id, references(:users, on_delete: :delete_all), null: false
  
    schema "user_following" do
      field :user_id, :id
      field :user_followed_id, :id

      timestamps()
    end
  
    def changeset(user_following, attrs) do
      user_following
      |> cast(attrs, [:user_id, :user_followed_id])
      |> validate_required([:user_id, :user_followed_id])
    end
  end