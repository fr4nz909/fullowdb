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
    test "posts field returns all posts" do
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

    @query """
    query ($term: String) {
        posts (matching: $term) {
          text
        }
    }
  """
  @variables %{"term" => "Wor"}
  test "posts field returns posts filtered by text with using a variable" do
      response = get(build_conn(), "/api", query: @query, variables: @variables)
      assert json_response(response, 200) == %{
          "data" => %{
              "posts" => [
                  %{"text" => "Hello again, World!"},
              ]
          }
      }
  end

    @query """
    {
        posts (matching: 123) {
            text
        }
    }
    """
    test "posts field returns errors when using a bad value" do
        response = get(build_conn(), "/api", query: @query)
        assert %{"errors" => [
            %{"message" => message}
        ]} = json_response(response, 200)
        assert message == "Argument \"matching\" has invalid value 123."
    end

end