defmodule FullowdbWeb.Router do
  use Phoenix.Router

  pipeline :api do
    plug FullowdbWeb.Context
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: FullowdbWeb.Schema

    forward "/", Absinthe.Plug, schema: FullowdbWeb.Schema
  end
end