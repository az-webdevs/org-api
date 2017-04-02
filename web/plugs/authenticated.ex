defmodule Org.Plugs.Authenticated do
  @behaviour Plug

  import Plug.Conn
  import Phoenix.Controller

  alias Org.Repo
  alias Org.User

  def init(default), do: default

  def call(conn, _) do
    current_user = get_session(conn, :current_user)

    if current_user do
      case Repo.get(User, current_user) do
        nil  -> conn
                |> configure_session(drop: true) # Drop invalid user session
                |> flash_and_redirect
        user -> assign(conn, :current_user, user)
      end
    else
      conn
      |> flash_and_redirect
    end
  end

  defp flash_and_redirect(conn) do
    conn
    |> put_flash(:error, "Please sign in")
    |> redirect(to: "/")
    |> halt
  end
end
