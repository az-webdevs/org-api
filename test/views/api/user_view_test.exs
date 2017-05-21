defmodule Org.Api.UserViewTest do
  use Org.ModelCase
  alias Org.Api.UserView

  test "user_json" do
    user = insert(:user)
    rendered_user = UserView.user_json(user)

    assert rendered_user == %{
      name: user.name,
      email: user.email,
      role: user.role
    }
  end

  test "index.json" do
    user = insert(:user)
    rendered_users = UserView.render("index.json", %{users: [user]})

    assert rendered_users == %{users: [UserView.user_json(user)]}
  end

  test "show.json" do
    user = insert(:user)
    rendered_user = UserView.render("show.json", %{user: user})

    assert rendered_user == %{user: UserView.user_json(user)}
  end
end
