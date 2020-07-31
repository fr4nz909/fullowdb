defmodule FullowdbWeb.Router do
  use FullowdbWeb, :router
  alias FullowdbWeb.PageController

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["http://localhost:3000", "http://127.0.0.1:3000"]
    plug(FullowdbWeb.Plugs.Context)
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: Fullowdb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: Fullowdb.Schema,
      interface: :simple
  end

  scope  "/web" do
    pipe_through :browser

    get "/", PageController, :index
  end
end
