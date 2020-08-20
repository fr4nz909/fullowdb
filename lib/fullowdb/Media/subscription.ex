defmodule Fullowdb.Subscription do
    use Fullowdb.Model
  
    alias Fullowdb.{User, Following}

    # add :title, :string, null: false
    # add :body, :text
    # add :price, :float, null: false
    # add :period_of_validity, :integer, null: false
  
    schema "subscriptions" do
      field :title, :string, null: false
      field :body, :string
      field :price, :float, null: false
      field :period_of_validity, :integer, null: false
    
      belongs_to :user, User
      has_many :followings, Following

      timestamps()
    end
  
    def changeset(following, attrs) do
      following
      |> cast(attrs, [:user_id, :title, :price, :period_of_validity])
      |> validate_required([:user_id, :title, :price, :period_of_validity])
      |> foreign_key_constraint(:user_id)
      |> foreign_key_constraint(:following_id)
    end
end