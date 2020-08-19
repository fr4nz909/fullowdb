defmodule Fullowdb.Seeds do

    def run() do
        alias Fullowdb.{Repo, Post, User}

        #
        # USERS
        # User.changeset(%User{}, %{username: "Harry", 
        # date_of_birth: "2000-12-12", email: "harry@potter.com", password: "password", password_confirmation: "password"})

        ferentine =
        %User{username: "A Ferentine", date_of_birth: "1999-24-10", email: "ferentine@tine.com", password: "password", password_confirmation: "password"}
        |> Repo.insert!

        martina =
        %User{username: "B Martina666", date_of_birth: "1996-24-10", email: "martina@tine.com", password: "password", password_confirmation: "password"}
        |> Repo.insert!

        #
        # TAGS
        #

        #firsttag =
        #%Tagging.Tag{name: "A Blonde"}
        #|> Repo.insert!

        #secondtag =
        #%Tagging.Tag{name: "B Brunette"}
        #|> Repo.insert!

        #thirdtag =
        #%Tagging.Tag{name: "C 18"}
        #|> Repo.insert!

        #fourthtag =
        #%Tagging.Tag{name: "D 30"}
        #|> Repo.insert!

        #
        # POSTS
        #

        _firstpost =
        %Post{body: "A Post", user: ferentine, post_media: ["https://www.time-4-dogs.com/s/img/emotionheader8192839.jpg?1483389627.920px.607px",]}
        |> Repo.insert!

        _secondpost =
        %Post{body: "B Post", user: martina, post_media: ["https://senco-dogs.de/wp-content/uploads/2019/10/Senco-Dogs-Ausbildungszentrum.jpg",]}
        |> Repo.insert!

        _thirdpost =
        %Post{body: "C Post", user: martina, post_media: ["https://www.martinruetter.com/fileadmin/_processed_/csm_0Y6A0455web_Fotor_Fotor_5a63c6fa8c.jpg",]}
        |> Repo.insert!

        _fourthpost =
        %Post{body: "D Post", user: ferentine, post_media: ["https://cdn.prod.www.spiegel.de/images/a305eaa3-1cec-4101-b08d-20b7074efe2a_w1200_r1_fpx65.97_fpy52.85.jpg", "https://upload.wikimedia.org/wikipedia/commons/f/f7/Stack_Overflow_logo.png"]}
        |> Repo.insert!

        :ok
    end
  end
  