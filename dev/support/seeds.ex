defmodule Fullowdb.Seeds do

    def run do
        alias Fullowdb.{Repo, Media}

        #
        # POSTS
        #

        firstpost =
        %Media.Post{text: "Hello again, World!"}
        |> Repo.insert!

        secondpost =
        %Media.Post{text: "hello"}
        |> Repo.insert!

        :ok
    end
  end
  