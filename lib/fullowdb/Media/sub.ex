defmodule Fullowdb.Sub do
    use Fullowdb.Model
  
    alias Fullowdb.{Repo, Following, User}

    #add :title, :string, null: false
    #add :body, :text
    #add :price, :float, null: false
    #add :period_of_validity, :integer, null: false
    #
    #add :user_id, references(:users, on_delete: :delete_all), null: false
    #add :following_id, references(:followings)
  
    schema "subs" do
      field :title, :string
      field :body, :string
      field :price, :float
      field :period_of_validity, :integer
  
      belongs_to :user, User
      has_many :followings, Following
  
      timestamps()
    end
  
    def all do
      Repo.all(from row in __MODULE__, order_by: [desc: row.id])
    end
  
    def changeset(post, attrs) do
      post
      |> cast(attrs, [:body, :price, :user_id, :title, :period_of_validity])  
      |> validate_required([:body, :price, :user_id, :title, :period_of_validity])
      |> foreign_key_constraint(:user_id)
    end
  end