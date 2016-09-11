defmodule Org.PageController do
  use Org.Web, :controller

  alias Org.Group
  alias Org.User

  def home(conn, _params) do
    groups = Repo.all(from g in Group, preload: [:user])
    render(conn, "home.html", groups: groups)
  end

  def signin(conn, _params) do
    groups = Repo.all(from g in Group, preload: [:user])
    render(conn, "signin.html", groups: groups)
  end

  def apply(conn, _params) do
    user = Repo.get!(User, conn.assigns.current_user.id)
    changeset = User.changeset(user)
    render(conn, "apply.html", user: user, changeset: changeset)
  end

  def thanks(conn, _params) do
    render(conn, "thanks.html")
  end
end
