defmodule Org.PageController do
  use Org.Web, :controller

  alias Org.Group
  alias Org.User

  def home(conn, _params) do
    groups = Repo.all(from g in Group, preload: :user)
    render(conn, "home.html", groups: groups)
  end

  def signin(conn, _params) do
    if (conn.assigns.current_user) do
      conn
      |> put_flash(:info, "You are already signed in.")
      |> redirect(to: "/apply")
    end
    render(conn, "signin.html")
  end

  def apply(conn, _params) do
    IO.puts "ping"
    user = Repo.get!(User, conn.assigns.current_user.id)
    |> Repo.preload(:languages)
    changeset = User.changeset(user)
    render(conn, "apply.html", user: user, changeset: changeset)
  end

  def thanks(conn, _params) do
    conn
    |> put_flash(:info, "Your application has been sent!")
    |> render("thanks.html")
  end
end
