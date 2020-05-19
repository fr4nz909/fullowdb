defmodule FullowdbWeb.Schema.FanshopTypes do
    use Absinthe.Schema.Notation

    @desc "Filtering options for the articles list"
    input_object :article_filter do
      @desc "Matching a Name"
      field :username, :string

      @desc "Matching a Tag"
      field :tag, :string

      @desc "Priced above a Value"
      field :priced_above, :float

      @desc "Priced below a Value"
      field :priced_below, :float

    end

    object :article_queries do

    @desc "The list of all available Articles"
    field :articles, list_of(:article) do
        arg :filter, :article_filter
        arg :matching, :string
        resolve &Resolvers.Fanshop.list_articles/3
    end

      #Other Fanshop-related fields

    end

    object :article do
        field :id, :id
        field :name, :string
        field :price, :float
    end
end