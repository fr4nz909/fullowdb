defmodule FullowdbWeb.Schema.FanshopTypes do
    use Absinthe.Schema.Notation
    alias FullowdbWeb.Resolvers

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

    object :article_result do
      field :article, :article
      field :errors, list_of(:input_error)
  end

    #add :name, :string, null: false
    #add :description, :string
    #add :price, :float, null: false
    #add :article_media, {:array, :string}, null: false
    #
    #add :user_id, references(:users, on_delete: :delete_all), null: false

    object :article do
        field :id, :id
        field :name, non_null(:string)
        field :description, :string
        field :price, non_null(:float)
        field :article_media, non_null(list_of(:string))
    end

    input_object :article_input do
        field :name, :string
        field :description, :string
        field :price, :float
        field :article_media, list_of(:string)

        field :user_id, :id
    end
end