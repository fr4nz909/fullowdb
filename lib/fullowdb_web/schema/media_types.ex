defmodule FullowdbWeb.Schema.MediaTypes do
    use Absinthe.Schema.Notation
    alias FullowdbWeb.Resolvers

    @desc "Filtering options for the post list"
    input_object :post_filter do
      @desc "Matching a Text"
      field :text, :string

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
        field :text, :string
        field :user, :user
        field :added_on, :date
    end

    object :story do
        field :id, :id
        field :text, :string
    end
end