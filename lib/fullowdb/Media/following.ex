defmodule Fullowdb.Following do
    use Fullowdb.Model
  
    alias Fullowdb.{User, Sub}
  
    schema "followings" do
      belongs_to :user, User
      belongs_to :follower, User

      belongs_to :sub, Sub

      timestamps()
    end
  
    def changeset(following, attrs) do
      following
      |> cast(attrs, [:user_id, :follower_id, :sub_id])
      |> validate_required([:user_id, :follower_id])
      |> foreign_key_constraint(:user_id)
      |> foreign_key_constraint(:follower_id)
    end
end