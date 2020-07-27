defmodule Fullowdb.Mediashop do
  @moduledoc """
  The Mediashop context.
  """

  import Ecto.Query, warn: false
  alias Fullowdb.Repo

  alias Fullowdb.Mediashop.MediaArticle

  @doc """
  Returns the list of media_articles.

  ## Examples

      iex> list_media_articles()
      [%MediaArticle{}, ...]

  """
  def list_media_articles do
    Repo.all(MediaArticle)
  end

  @doc """
  Gets a single media_article.

  Raises `Ecto.NoResultsError` if the Media article does not exist.

  ## Examples

      iex> get_media_article!(123)
      %MediaArticle{}

      iex> get_media_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_media_article!(id), do: Repo.get!(MediaArticle, id)

  @doc """
  Creates a media_article.

  ## Examples

      iex> create_media_article(%{field: value})
      {:ok, %MediaArticle{}}

      iex> create_media_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_media_article(attrs \\ %{}) do
    %MediaArticle{}
    |> MediaArticle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a media_article.

  ## Examples

      iex> update_media_article(media_article, %{field: new_value})
      {:ok, %MediaArticle{}}

      iex> update_media_article(media_article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_media_article(%MediaArticle{} = media_article, attrs) do
    media_article
    |> MediaArticle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a media_article.

  ## Examples

      iex> delete_media_article(media_article)
      {:ok, %MediaArticle{}}

      iex> delete_media_article(media_article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_media_article(%MediaArticle{} = media_article) do
    Repo.delete(media_article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking media_article changes.

  ## Examples

      iex> change_media_article(media_article)
      %Ecto.Changeset{data: %MediaArticle{}}

  """
  def change_media_article(%MediaArticle{} = media_article, attrs \\ %{}) do
    MediaArticle.changeset(media_article, attrs)
  end
end
