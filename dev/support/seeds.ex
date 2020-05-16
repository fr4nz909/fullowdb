defmodule Fullowdb.Seeds do

    def run() do
        alias Fullowdb.{Repo, Media, Account}

        #
        # USERS
        #

        ferentine =
        %Account.User{username: "A Ferentine"}
        |> Repo.insert!

        martina =
        %Account.User{username: "B Martina666"}
        |> Repo.insert!

        #
        # POSTS
        #

        firstpost =
        %Media.Post{text: "A Post"}
        |> Repo.insert!

        secondpost =
        %Media.Post{text: "B Post"}
        |> Repo.insert!

        thirdpost =
        %Media.Post{text: "C Post", user: martina}
        |> Repo.insert!

        fourthpost =
        %Media.Post{text: "D Post", user: ferentine}
        |> Repo.insert!

        :ok
    end
  end
  