defmodule FullowdbWeb.Schema.Types.MediaTypes do
    use Absinthe.Schema.Notation

    alias FullowdbWeb.Resolvers

    @desc "Filtering options for the post list"
    input_object :post_filter do
      @desc "Matching a Post-Text"
      field :post_text, :string

      @desc "Matching a Tag"
      field :tag, :string

      @desc "Post added before this date"
      field :added_before, :date

      @desc "Post added after this date"
      field :added_after, :date

    end

    object :post_queries do

        @desc  "The list of all available Posts"
        field :posts, list_of(:post) do
          arg :filter, non_null(:post_filter)
          arg :order, type: :sort_order, default_value: :asc
          resolve &Resolvers.Media.list_posts/3
      end

      #Other Media-related fields

    end

    object :post do
        field :id, :id
        field :post_text, :string
        field :post_media, list_of(:string)
        field :inserted_at, :date
        field :user, :user
    end

    object :story do
        field :id, :id
        field :text, :string
    end

    object :tag do
        field :name, :string
        field :description, :string
        field :posts, list_of(:post) do
            resolve &Resolvers.Media.posts_for_tag/3
        end
    end

    interface :search_result do
        field :name, :string
        resolve_type fn
            %Fullowdb.Media.Post{}, _ ->
                :post
            %Fullowdb.Tagging.Tag{}, _ ->
                :tag
            _, _ ->
                nil
            end
        end

        input_object :post_input do
            field :text, non_null(:string)
            field :user_id, non_null(:id)
        end

        input_object :story_input do
            field :text, non_null(:string)
            field :user_id, non_null(:id)
        end
    end