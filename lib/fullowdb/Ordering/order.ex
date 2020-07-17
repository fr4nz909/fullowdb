defmodule Fullowdb.Ordering.Order do
    use Ecto.Schema
    import Ecto.Changeset
    alias Fullowdb.Ordering.Order
  
    schema "orders" do
      field :customer_id, :integer
      field :seller_id, :integer
      
      field :ordered_at, :utc_datetime, read_after_writes: true
      field :state, :string, read_after_writes: true
  
      embeds_many :items, Fullowdb.Ordering.Item
  
      timestamps()
    end
  
    @doc false
    def changeset(%Order{} = order, attrs) do
      order
      |> cast(attrs, [:customer_id, :seller_id, :ordered_at, :state])
      |> cast_embed(:items)
    end
  end