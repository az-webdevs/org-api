defmodule Org.UserControllerTest do
  use Org.ConnCase

  alias Org.Api.UserView

  describe "with an authenticated user" do
    test "#index lists all non-user role users", %{conn: conn} do
      [member, _] = [insert(:user), insert(:user, role: "user")]
      conn = 
        conn
        |> assign(:current_user, member)
        |> get(user_path(conn, :index))

      assert json_response(conn, 200) == render_json(UserView, "index.json", users: [member])
    end

    test "#show renders a user", %{conn: conn} do
      user = insert(:user)
      conn = 
        conn
        |> assign(:current_user, user)
        |> get(user_path(conn, :show, user))

      assert json_response(conn, 200) == render_json(UserView, "show.json", user: user)
    end

    test "#show renders user not found when id is nonexistent", %{conn: conn} do
      user = insert(:user)
      assert_error_sent 404, fn ->
        conn
        |> assign(:current_user, user)
        |> get(user_path(conn, :show, 1234))
      end
    end
  end

  describe "with a non-authenticated user" do
    test "returns a 401", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert json_response(conn, 401) == render_json(Org.ErrorView, "401.json")
    end
  end

#   test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
#     user = Repo.insert! %User{}
#     conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
#     assert html_response(conn, 200) =~ "Edit user"
#   end
end
