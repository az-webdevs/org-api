defmodule Org.Api.UserController do
  use Org.Web, :controller

  import Org.User.Permissions
  import Org.Controller.Helpers

  alias Org.User

  plug :authenticate_for_roles, ~w(admin member) when action in [:index, :show, :update]

  def index(conn, _params) do
    users =
      User
      |> limit_for(current_user(conn).role)
      |> Repo.all

    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user =
      User
      |> limit_for(current_user(conn).role)
      |> Repo.get!(id)

    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    User
    |> limit_for(current_user(conn).role)
    |> Repo.get!(id)
    |> authorize!(:update, current_user(conn))
    |> User.changeset(user_params)
    |> update_user(conn, &(render(conn, "show.json", user: &1)))
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

  defp update_user(changeset, conn, func) do
    case Repo.update(changeset) do
      {:ok, user} ->
        func.(user)
      {:error, %{errors: errors}} ->
        conn
        |> put_status(409)
        |> render(Org.ErrorView, "409.json", errors: errors)
    end
  end
end
