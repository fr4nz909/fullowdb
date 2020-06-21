defmodule Fullowdb.Seeds do

    def run() do
        alias Fullowdb.{Repo, Media, Account, Tagging}

        #
        # USERS
        # User.changeset(%User{}, %{username: "Harry", 
        # date_of_birth: "2000-12-12", email: "harry@potter.com", password: "password", password_confirmation: "password"})

        ferentine =
        %Account.User{username: "A Ferentine", date_of_birth: "1999-24-10", email: "ferentine@tine.com", password: "password", password_confirmation: "password"}
        |> Repo.insert!

        martina =
        %Account.User{username: "B Martina666", date_of_birth: "1996-24-10", email: "martina@tine.com", password: "password", password_confirmation: "password"}
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

        _firstpost =
        %Media.Post{post_text: "A Post", user: ferentine, tags: [firsttag], post_media: ["https://www.time-4-dogs.com/s/img/emotionheader8192839.jpg?1483389627.920px.607px",]}
        |> Repo.insert!

        _secondpost =
        %Media.Post{post_text: "B Post", user: martina, tags: [secondtag], post_media: ["https://senco-dogs.de/wp-content/uploads/2019/10/Senco-Dogs-Ausbildungszentrum.jpg",]}
        |> Repo.insert!

        _thirdpost =
        %Media.Post{post_text: "C Post", user: martina, tags: [thirdtag], post_media: ["https://www.martinruetter.com/fileadmin/_processed_/csm_0Y6A0455web_Fotor_Fotor_5a63c6fa8c.jpg",]}
        |> Repo.insert!

        _fourthpost =
        %Media.Post{post_text: "D Post", user: ferentine, tags: [fourthtag], post_media: ["https://cdn.prod.www.spiegel.de/images/a305eaa3-1cec-4101-b08d-20b7074efe2a_w1200_r1_fpx65.97_fpy52.85.jpg", "https://upload.wikimedia.org/wikipedia/commons/f/f7/Stack_Overflow_logo.png"]}
        |> Repo.insert!

        :ok
    end
  end
  