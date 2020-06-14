defmodule FullowdbWeb.Schema.Mutation.CreateArticleTest do
    use FullowdbWeb.ConnCase, async: true

    alias Fullowdb.{Repo, Fanshop, Account}
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
mutation ($article: ArticleInput!) {
    createArticle(input: $article) {
        name
        description
        price
        mediaUrl
    }
}
"""
test "createArticle field creates an Article", %{
    user_id: user_id} do
        article = %{
            "name" => "String Tanga",
            "description" => "My String Tanga from my last show",
            "price" => 5.0,
            "mediaUrl" => "google.com",
            "userId" => user_id,
        }
        conn = build_conn()
        conn = post conn, "/api",
        query: @query,
        variables: %{"article" => article}

        assert json_response(conn, 200) == %{
            "data" => %{
                "createArticle" => %{
                    "name" => article["name"],
                    "description" => article["description"],
                    "price" => article["price"],
                    "mediaUrl" => article["mediaUrl"],
                }
            }
        }
    end
end