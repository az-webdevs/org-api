defmodule Org.AuthController do
  use Org.Web, :controller

  alias Org.User

  @doc """
  This action is reached via `/auth/:provider` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/:provider/callback` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"provider" => provider, "code" => code}) do
    # Exchange an auth code for an access token
    token = get_token!(provider, code)

    # Request the user's data with the access token
    user = get_user!(provider, token)

    # Store the user in the session under `:current_user` and redirect to /.
    conn
    |> put_session(:current_user, Map.get(user, :id))
    |> put_session(:access_token, token.access_token)
    |> redirect(to: "/")
  end

  defp authorize_url!("github"),   do: GitHub.authorize_url!
  defp authorize_url!(_), do: raise "No matching provider available"

  defp get_token!("github", code),   do: GitHub.get_token!(code: code)
  defp get_token!(_, _), do: raise "No matching provider available"

  defp get_user!("github", token) do
    {:ok, %{body: user}} = OAuth2.AccessToken.get(token, "/user")
    user = %{
      avatar: user["avatar_url"],
      bio: user["bio"],
      blog: user["blog"],
      company: user["company"],
      created_at: user["created_at"],
      email: user["email"],
      followers: user["followers"],
      following: user["following"],
      github_id: user["id"],
      hireable: user["hireable"],
      html_url: user["html_url"],
      location: user["location"],
      login: user["login"],
      name: user["name"],
      public_gists: user["public_gists"],
      public_repos: user["public_repos"],
      type: user["type"]
    }
    find_or_create_user(user)
  end

  defp find_or_create_user(user) do
    case Repo.get_by(User, github_id: user[:github_id]) do
      nil  -> %User{} # User not found, we build one
      user -> user    # User exists, let's use it
    end
    user
    |> User.changeset
    |> Repo.insert_or_update!
  end
end
