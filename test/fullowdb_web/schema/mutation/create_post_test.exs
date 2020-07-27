defmodule FullowdbWeb.Schema.Mutation.CreatePostTest do
    use FullowdbWeb.ConnCase, async: true

    alias Fullowdb.{Repo, Media, Account}

    import Ecto.Query

    setup do
        Fullowdb.Seeds.run()

        user_id = 
        from(t in Account.User, where: t.username == "A Ferentine")
        |> Repo.one!
        |> Map.fetch!(:id)
        |> to_string

        {:ok, user_id: user_id}
    end

    @query """
    mutation ($post: PostInput!) {
        createPost(input: $post) {
            postText
        }
    }
    """
    test "createPost field creates a post", %{
        user_id: user_id} do
            post = %{
                "postText" => "This is a test post I created via a mutation!",
                "userId" => user_id
            }
            conn = build_conn()
            conn = post conn, "/api",
            query: @query,
            variables: %{"post" => post}

            assert json_response(conn, 200) == %{
                "data" => %{
                    "createPost" => %{
                        "postText" => post["text"],
                    }
                }
            }
        end
end