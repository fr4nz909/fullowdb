defmodule FullowdbWeb.Data do
    import Ecto.Query
    alias Fullowdb.Repo
  
    def data() do
      Dataloader.Ecto.new(Repo, query: &query/2)
    end
  
    def query(queryable, params) do
      case Map.get(params, :order_by) do
        nil -> queryable
        order_by -> from record in queryable, order_by: ^order_by
      end
    end

    def query(queryable, _) do
      queryable
    end
  end