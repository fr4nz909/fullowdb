defmodule FullowdbWeb.Schema.Query.PostsTest do
    use FullowdbWeb.ConnCase, async: true

    setup do
        Fullowdb.Seeds.run()
    end

    @query """
      {
          posts {
            text
          }
      }
    """
    test "posts field returns posts" do
        conn = build_conn()
        conn = get conn, "/api", query: @query
        assert json_response(conn, 200) == %{
            "data" => %{
                "posts" => [
                    %{"text" => "Hello again, World!"},
                    %{"text" => "hello"},
                ]
            }
        }
    end
end