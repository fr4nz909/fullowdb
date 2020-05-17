defmodule FullowdbWeb.Schema.Query.PostsTest do
    use FullowdbWeb.ConnCase, async: true

    setup do
        Fullowdb.Seeds.run()
    end

    @query """
      {
          posts (filter: "") {
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
        posts (filter: {text: 123}) {
            text
        }
    }
    """
    test "posts field returns errors when using a bad value" do
        response = get(build_conn(), "/api", query: @query)
        assert %{"errors" => [
            %{"message" => message}
        ]} = json_response(response, 200)
        assert message == "Argument \"filter\" has invalid value {text: 123}.\nIn field \"text\": Expected type \"String\", found 123."
    end

    @query """
    {
        posts (order: DESC, filter: "") {
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
    query ($order: SortOrder!, $filter: PostFilter){
        posts (order: $order, filter: $filter) {
            text
        }
    }
    """
    @variables %{"order" => "DESC", "filter" => ""}
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

    @query """
    query ($filter: PostFilter!) {
        posts(filter: $filter) {
            text
        }
    }
    """
    
    @variables %{filter: %{"tag" => "C 18", "text" => "C"}}
    test "Posts field returns Posts, filtering with variables" do
        response = get(build_conn(), "/api", query: @query, variables: @variables)
        assert %{
            "data" => %{"posts" => [%{"text" => "C Post"}]}
        } == json_response(response, 200)
    end

    @query """
    query ($filter: PostFilter!) {
        posts(filter: $filter) {
            text
            addedOn
        }
    }
    """
    
    @variables %{filter: %{"addedBefore" => "2020-05-17"}}
    test "Posts field filtered by custom scalar type (date)" do
        dateFilteringTestUser = Fullowdb.Repo.get_by!(Fullowdb.Account.User, username: "B Martina666")
        %Fullowdb.Media.Post{
            text: "This is a post testing filtering on date type",
            added_on: ~D[2020-01-01],
            user: dateFilteringTestUser,
        } |> Fullowdb.Repo.insert!

        response = get(build_conn(), "/api", query: @query, variables: @variables)
        assert %{
            "data" => %{"posts" => [%{"text" => "This is a post testing filtering on date type", "addedOn" => "2020-01-01"}]
        }
        } == json_response(response, 200)
    end
end