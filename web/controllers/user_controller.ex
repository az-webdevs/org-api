defmodule Org.Api.UserController do
  use Org.Web, :controller

  alias Org.User

  plug :authenticate_self when action in [:update, :apply]

  def index(conn, _params) do
    users = Repo.all(from u in User, where: u.role != "user")
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, _changeset} ->
        put_flash(conn, :error, "Failed to update user.")
    end
  end

  def apply(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    user_params = Map.put(user_params, "has_applied", true)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        # TODO: send application details to Slack
        conn
        |> put_flash(:info, "Application submitted successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "apply.html", user: user, changeset: changeset)
    end
  end
end
