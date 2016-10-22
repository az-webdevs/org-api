defmodule Org.UserTest do
  use Org.ModelCase

  alias Org.User

  @valid_attrs %{avatar: "some content", bio: "some content", blog: "some content", comments: "some content", company: "some content", created_at: "some content", email: "some content", followers: 42, following: 42, github_id: 42, has_applied: true, hireable: true, html_url: "some content", languages: [], location: "some content", login: "some content", name: "some content", public_gists: 42, public_repos: 42, role: "some content", type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
