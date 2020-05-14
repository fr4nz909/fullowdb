defmodule FullowdbWeb.PageController do
  use FullowdbWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
