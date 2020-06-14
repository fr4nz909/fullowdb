defmodule FullowdbWeb.Schema.Mutation.CreateStoryTest do
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
    mutation ($story: StoryInput!) {
        createStory(input: $story) {
            text
        }
    }
    """
    test "createStory field creates a story", %{
        user_id: user_id} do
            story = %{
                "text" => "This is a test story I created via a mutation!",
                "userId" => user_id
            }
            conn = build_conn()
            conn = post conn, "/api",
            query: @query,
            variables: %{"story" => story}

            assert json_response(conn, 200) == %{
                "data" => %{
                    "createStory" => %{
                        "text" => story["text"],
                    }
                }
            }
        end
end