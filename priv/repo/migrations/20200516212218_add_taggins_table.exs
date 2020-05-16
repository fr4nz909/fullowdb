defmodule Fullowdb.Repo.Migrations.AddTagginsTable do
  use Ecto.Migration

  def change do
    create table(:posts_taggings, primary_key: false) do
      add :post_id, references(:posts), null: false
      add :tag_id, references(:tags), null: false
    end
  end
end
