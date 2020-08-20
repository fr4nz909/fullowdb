defmodule Fullowdb.Following do
    use Fullowdb.Model
  
    alias Fullowdb.User
  
    schema "followings" do
      belongs_to :user, User
      belongs_to :follower, User
  
      timestamps()
    end
  
    def changeset(following, attrs) do
      following
      |> cast(attrs, [:user_id, :follower_id])
      |> validate_required([:user_id, :follower_id])
      |> foreign_key_constraint(:user_id)
      |> foreign_key_constraint(:user_id)
    end
end