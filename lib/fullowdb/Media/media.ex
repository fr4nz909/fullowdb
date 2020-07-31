defmodule Fullowdb.Media do
    import Ecto.Query, warn: false
    alias Fullowdb.Repo

    alias Fullowdb.Media.Post
    alias Fullowdb.Media.Story
    
    alias Fullowdb.Tagging.Tag

    def create_post(attrs \\ %{}) do
        %Post{}
        |> Post.changeset(attrs)
        |> Repo.insert()
    end

    def create_story(attrs \\ %{}) do
        %Story{}
        |> Story.changeset(attrs)
        |> Repo.insert()
    end

    def list_post!(id), do: Repo.get!(Post, id)

    def list_posts(user, args) do
        args
        |> Enum.reduce(Post, fn
            {:order, order}, query ->
                query |> order_by({^order, :post_text})
                {:filter, filter}, query ->
                    query |> filter_with(filter)
                end)
        |> Repo.all
    end

    def list_posts(args) do
        IO.puts "These are the given arguments: #{inspect(args)}"
        args
        |> Enum.reduce(Post, fn
            {:order, order}, query ->
                query |> order_by({^order, :post_text})
                {:filter, filter}, query ->
                    query |> filter_with(filter)
                end)
        |> Repo.all
    end

    def list_stories(_) do
        Repo.all(Story)
    end

    @search [Post, Tag]
    def search(term) do
        pattern = "%#{term}%"
        Enum.flat_map(@search, &search_ecto(&1, pattern))
    end

    defp search_ecto(ecto_schema, pattern) do
        Repo.all from q in ecto_schema,
        where: ilike(q.name, ^pattern) or ilike(q.description, ^pattern)
    end

    defp filter_with(query, filter) do
        Enum.reduce(filter, query, fn
            {:text, text}, query ->
                from q in query, where: ilike(q.post_text, ^"%#{text}%")
            {:tag, tag_name}, query ->
                from q in query, join: t in assoc(q, :tags),
                where: ilike(t.name, ^"%#{tag_name}%")
            {:added_after, date}, query ->
                from q in query, where: q.added_on <= ^date
            {:added_before, date}, query ->
                from q in query, where: q.added_on <= ^date
            end)
    end
end