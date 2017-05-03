defmodule Org.UserView do
  use Org.Web, :view

  def render("index.json", %{users: users}) do
    %{
      users: Enum.map(users, &(user_json(&1)))
    }
  end

  def user_json(user) do
    %{
      name: user.name
    }
  end
end
