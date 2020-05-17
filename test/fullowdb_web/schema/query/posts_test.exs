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
                    %{"text" => "A Post"},
                    %{"text" => "B Post"},
                    %{"text" => "C Post"}, 
                    %{"text" => "D Post"},
                ]
            }
        }
    end

    @query """
    query ($filter: PostFilter!) {
        posts (filter: $filter) {
          text
        }
    }
  """
  @variables %{filter: %{"text" => "C"}}
  test "posts field returns posts filtered by text with using a variable" do
      response = get(build_conn(), "/api", query: @query, variables: @variables)
      assert json_response(response, 200) == %{
          "data" => %{
              "posts" => [
                  %{"text" => "C Post"},
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

    @query """
    {
        posts (order: DESC) {
            text
        }
    }
    """
    test "posts field returns posts descending using literals" do
        response = get(build_conn(), "/api", query: @query)
        assert %{
            "data" => %{"posts" => [%{"text" => "D Post"} | _]}  
        } = json_response(response, 200)
    end

    @query """
    query ($order: SortOrder!){
        posts (order: $order) {
            text
        }
    }
    """
    @variables %{"order" => "DESC"}
    test "posts field returns posts descending using variables" do
        response = get(build_conn(), "/api", query: @query, variables: @variables)
        assert %{
            "data" => %{"posts" => [%{"text" => "D Post"} | _]}  
        } = json_response(response, 200)
    end

    @query """
    {
        posts (filter: {tag: "A Blonde"}) {
            text
        }
    }
    """
    test "Posts field returns Posts (with tags), filtering with a literal" do
        response = get(build_conn(), "/api", query: @query)
        assert %{
            "data" => %{"posts" => [%{"text" => "A Post"}]}
        } == json_response(response, 200)
    end

end