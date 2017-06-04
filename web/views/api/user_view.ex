defmodule Org.Api.UserView do
  use Org.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Org.Api.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Org.Api.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      name: user.name,
      email: user.email,
      role: user.role,
      bio: user.bio
    }
  end
end
