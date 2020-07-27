defmodule Fullowdb.MediashopTest do
  use Fullowdb.DataCase

  alias Fullowdb.Mediashop

  describe "articles" do
    alias Fullowdb.Mediashop.Article

    @valid_attrs %{description: "some description", name: "some name", price: 120.5}
    @update_attrs %{description: "some updated description", name: "some updated name", price: 456.7}
    @invalid_attrs %{description: nil, name: nil, price: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mediashop.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Mediashop.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Mediashop.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Mediashop.create_article(@valid_attrs)
      assert article.description == "some description"
      assert article.name == "some name"
      assert article.price == 120.5
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mediashop.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Mediashop.update_article(article, @update_attrs)
      assert article.description == "some updated description"
      assert article.name == "some updated name"
      assert article.price == 456.7
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Mediashop.update_article(article, @invalid_attrs)
      assert article == Mediashop.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Mediashop.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Mediashop.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Mediashop.change_article(article)
    end
  end

  describe "media_articles" do
    alias Fullowdb.Mediashop.MediaArticle

    @valid_attrs %{description: "some description", name: "some name", price: 120.5}
    @update_attrs %{description: "some updated description", name: "some updated name", price: 456.7}
    @invalid_attrs %{description: nil, name: nil, price: nil}

    def media_article_fixture(attrs \\ %{}) do
      {:ok, media_article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mediashop.create_media_article()

      media_article
    end

    test "list_media_articles/0 returns all media_articles" do
      media_article = media_article_fixture()
      assert Mediashop.list_media_articles() == [media_article]
    end

    test "get_media_article!/1 returns the media_article with given id" do
      media_article = media_article_fixture()
      assert Mediashop.get_media_article!(media_article.id) == media_article
    end

    test "create_media_article/1 with valid data creates a media_article" do
      assert {:ok, %MediaArticle{} = media_article} = Mediashop.create_media_article(@valid_attrs)
      assert media_article.description == "some description"
      assert media_article.name == "some name"
      assert media_article.price == 120.5
    end

    test "create_media_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mediashop.create_media_article(@invalid_attrs)
    end

    test "update_media_article/2 with valid data updates the media_article" do
      media_article = media_article_fixture()
      assert {:ok, %MediaArticle{} = media_article} = Mediashop.update_media_article(media_article, @update_attrs)
      assert media_article.description == "some updated description"
      assert media_article.name == "some updated name"
      assert media_article.price == 456.7
    end

    test "update_media_article/2 with invalid data returns error changeset" do
      media_article = media_article_fixture()
      assert {:error, %Ecto.Changeset{}} = Mediashop.update_media_article(media_article, @invalid_attrs)
      assert media_article == Mediashop.get_media_article!(media_article.id)
    end

    test "delete_media_article/1 deletes the media_article" do
      media_article = media_article_fixture()
      assert {:ok, %MediaArticle{}} = Mediashop.delete_media_article(media_article)
      assert_raise Ecto.NoResultsError, fn -> Mediashop.get_media_article!(media_article.id) end
    end

    test "change_media_article/1 returns a media_article changeset" do
      media_article = media_article_fixture()
      assert %Ecto.Changeset{} = Mediashop.change_media_article(media_article)
    end
  end
end
