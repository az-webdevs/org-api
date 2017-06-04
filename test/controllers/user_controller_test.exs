defmodule Org.UserControllerTest do
  use Org.ConnCase

  alias Org.Api.UserView

  setup %{conn: conn} = config do
    if role = config[:login_as] do
      user = insert(:user, role: role)
      conn = assign(build_conn(), :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  # Tests for index/2 action
  @tag login_as: "member"
  test "index/2 lists all non-user role users", %{conn: conn, user: member} do
    [admin, _] = [insert(:user, role: "admin"), insert(:user, role: "user")]
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200) == render_json(UserView, "index.json", users: [member, admin])
  end

  @tag login_as: "admin"
  test "index/2 lists all users", %{conn: conn, user: admin} do
    [user, member] = [insert(:user, role: "user"), insert(:user, role: "member")]
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200) == render_json(UserView, "index.json", users: [admin, user, member])
  end

  test "returns a 401 when a user is not authorized", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 401) == render_json(Org.ErrorView, "401.json")
  end

  @tag login_as: "user"
  test "index/2 returns a 403 when a \"user\" attempts to access it", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 403) == render_json(Org.ErrorView, "403.json")
  end

  # Tests for show/2 action
  @tag login_as: "member"
  test "show/2 renders a user", %{conn: conn, user: member} do
    conn = get conn, user_path(conn, :show, member)
    assert json_response(conn, 200) == render_json(UserView, "show.json", user: member)
  end

  @tag login_as: "member"
  test "show/2 returns a 404 when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, 1234)
    end
  end

  @tag login_as: "member"
  test "show/2 returns a 404 when the id is of a \"user\" and the current_user is a member", %{conn: conn} do
    assert_error_sent 404, fn ->
      user = insert(:user, role: "user")
      get conn, user_path(conn, :show, user)
    end
  end

  # Tests for update/2 action
  @tag login_as: "member"
  test "update/2 returns an updated member", %{conn: conn, user: member} do
    params = %{bio: "My new bio"}
    conn = put conn, user_path(conn, :update, member), user: params
    assert json_response(conn, 200)["data"]["bio"] == params.bio
  end

  @tag login_as: "member"
  test "update/2 returns a 403 when a member tries to update another member", %{conn: conn} do
    assert_error_sent 403, fn ->
      member = insert(:user, role: "member")
      put conn, user_path(conn, :update, member), user: %{bio: "bio"}
    end
  end

  @tag login_as: "user"
  test "update/2 returns a 403 when a user tries to access the action", %{conn: conn, user: user} do
    conn = put conn, user_path(conn, :update, user)
    assert json_response(conn, 403) == render_json(Org.ErrorView, "403.json")
  end

  @tag login_as: "member"
  test "update/2 returns a 409 when provided an invalid changeset", %{conn: conn, user: member} do
    conn = put conn, user_path(conn, :update, member), user: %{}
    assert json_response(conn, 409) == render_json(Org.ErrorView, "409.json")
  end

  # Tests for #apply action
end
