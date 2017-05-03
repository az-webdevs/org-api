defmodule Org.TestHelpers do
  require IEx
  alias Org.Repo
  alias Org.User

  def insert_user(attrs \\ %{}) do
    changes = Map.merge(%{
      avatar: "String",
      blog: "My Blog",
      company: "My Company",
      email: "email@email.com",
      followers: 1,
      following: 1,
      github_id: 1,
      html_url: "https://github.com",
      location: "Tempe",
      login: "String",
      public_gists: 1,
      public_repos: 1,
      type: "user"
    }, Enum.into(attrs, %{}))
    IEx.pry

    %User{}
    |> User.changeset(changes)
    |> Repo.insert!()
  end
end
