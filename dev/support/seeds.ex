defmodule Fullowdb.Seeds do

    def run() do
        alias Fullowdb.{Repo, Media, Account, Tagging}

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
        # TAGS
        #

        firsttag =
        %Tagging.Tag{name: "A Blonde"}
        |> Repo.insert!

        secondtag =
        %Tagging.Tag{name: "B Brunette"}
        |> Repo.insert!

        thirdtag =
        %Tagging.Tag{name: "C 18"}
        |> Repo.insert!

        fourthtag =
        %Tagging.Tag{name: "D 30"}
        |> Repo.insert!

        #
        # POSTS
        #

        firstpost =
        %Media.Post{text: "A Post", user: ferentine, tags: [firsttag]}
        |> Repo.insert!

        secondpost =
        %Media.Post{text: "B Post", user: martina, tags: [secondtag]}
        |> Repo.insert!

        thirdpost =
        %Media.Post{text: "C Post", user: martina, tags: [thirdtag]}
        |> Repo.insert!

        fourthpost =
        %Media.Post{text: "D Post", user: ferentine, tags: [fourthtag]}
        |> Repo.insert!

        :ok
    end
  end
  