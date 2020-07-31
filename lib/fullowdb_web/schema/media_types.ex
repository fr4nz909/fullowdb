defmodule FullowdbWeb.Schema.Types.MediaTypes do
    use Absinthe.Schema.Notation
    alias FullowdbWeb.Resolvers
    alias FullowdbWeb.Schema.Middleware

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
          #middleware(Middleware.Authorize, :any)
          resolve &Resolvers.Media.list_posts/3
      end

      #Other Media-related fields

      @desc "Get one Post by its ID"
      field :post, :post do
        arg :id, non_null(:integer)
        resolve &Resolvers.Media.list_post/3
      end

    end

    object :post_result do
        field :post, :post
        field :errors, list_of(:input_error)
    end

    object :story_result do
        field :story, :story
        field :errors, list_of(:input_error)
    end

    object :post do
        field :id, :id
        field :post_text, :string
        field :post_media, list_of(:string)
        field :inserted_at, :date
        field :is_premium, :boolean

        field :user, :user
    end

    # Works well, but when INPUT is done, the query responses with "null" for the filled fields...
    input_object :post_input do
        field :post_text, non_null(:string)
        field :post_media, non_null(list_of(:string))

        field :user_id, :id
    end

    #add :is_photo, :boolean
    #add :story_media, :string, null: false
    #add :story_text, :string
    #add :is_premium, :boolean, default: false, null: false
    #
    #add :user_id, references(:users, on_delete: :delete_all), null: false

    input_object :story_input do
        field :story_text, non_null(:string)
        field :story_media, non_null(:string)
        field :user_id, non_null(:id)
    end

    object :story do
        field :id, :id
        field :story_text, :string
        field :story_media, :string
        field :user_id, :id
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
    end