defmodule Org.Api.UserViewTest do
  use Org.ModelCase
  alias Org.Api.UserView

  test "user.json" do
    user = insert(:user)
    rendered_user = UserView.render("user.json", %{user: user})

    assert rendered_user == %{
      name: user.name,
      email: user.email,
      role: user.role,
      bio: user.bio
    }
  end

  test "index.json" do
    user = insert(:user)
    rendered_users = UserView.render("index.json", %{users: [user]})

    assert rendered_users == %{data: [UserView.render("user.json", %{user: user})]}
  end

  test "show.json" do
    user = insert(:user)
    rendered_user = UserView.render("show.json", %{user: user})

    assert rendered_user == %{data: UserView.render("user.json", %{user: user})}
  end
end
