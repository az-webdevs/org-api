defmodule Org.Plugs.Auth do
  @behaviour Plug

  import Plug.Conn
  import Phoenix.Controller

  alias Org.Repo
  alias Org.User

  def init(default), do: default

  def call(conn, _opts) do
    user_id = get_session(conn, :current_user)

    cond do
      current_user = conn.assigns[:current_user] ->
        conn
      current_user = user_id && Repo.get(User, user_id) ->
        assign(conn, :current_user, current_user)
      true ->
        assign(conn, :current_user, nil)
    end
  end

  def authenticated(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_status(401)
      |> render(Org.ErrorView, "401.json", [])
      |> halt()
    end
  end

  def authenticate_for_roles(conn, roles) do
    if Enum.member?(roles, conn.assigns.current_user.role) do
      conn
    else
      conn
      |> put_status(403)
      |> render(Org.ErrorView, "403.json", [])
      |> halt()
    end
  end
end
