defmodule Org.UserControllerTest do
  use Org.ConnCase

  alias Org.User
  alias Org.Api.UserView

  @invalid_attrs %{}

  describe "#index" do
    test "lists all non-user role users", %{conn: conn} do
      [member, _] = [insert(:user), insert(:user, role: "user")]
      conn = get conn, user_path(conn, :index)
      assert json_response(conn, 200) == render_json(UserView, "index.json", users: [member])
    end
  end

  describe "#show" do
    test "renders a user", %{conn: conn} do
      user = insert(:user)
      conn = get conn, user_path(conn, :show, user)
      assert json_response(conn, 200) == render_json(UserView, "show.json", user: user)
    end

    test "renders user not found when id is nonexistent", %{conn: conn} do
      assert_error_sent 404, fn ->
        get conn, user_path(conn, :show, 1234)
      end
    end
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New user"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user"
  end
end
