defmodule Org.Plugs.AuthTest do
  use Org.ConnCase
  alias Org.Plugs.Auth
  alias Org.User

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(Org.Router, :api)

    {:ok, %{conn: conn}}
  end

  test "call places user from session into assigns", %{conn: conn} do
    user = insert(:user)
    conn =
      conn
      |> get("/")
      |> put_session(:current_user, user.id)
      |> Auth.call([])

    assert conn.assigns.current_user.id == user.id
  end

  test "call with no session sets current_user assign to nil", %{conn: conn} do
    conn =
      conn
      |> get("/")
      |> Auth.call([])

    assert conn.assigns.current_user == nil
  end

  test "authenticated continues when current_user exists", %{conn: conn} do
    conn =
      conn
      |> get("/")
      |> assign(:current_user, %User{})
      |> Auth.authenticated([])

    refute conn.halted
  end

  test "authenticated halts when no current_user exists", %{conn: conn} do
    conn =
      conn
      |> get("/")
      |> Auth.authenticated([])

    assert conn.halted
  end

  test "authenticate_for_roles continues when the current_user matches the specified roles", %{conn: conn} do
    conn =
      conn
      |> get("/")
      |> assign(:current_user, %User{role: "member"})
      |> Auth.authenticate_for_roles(["member"])

    refute conn.halted
  end

  test "authenticate_for_roles halts when the current_user does not match the specified roles", %{conn: conn} do
    conn =
      conn
      |> get("/")
      |> assign(:current_user, %User{role: "member"})
      |> Auth.authenticate_for_roles(["admin"])

    assert conn.halted
  end
end
