defmodule Org.Factory do
  use ExMachina.Ecto, repo: Org.Repo

  def user_factory do
    %Org.User{
      name: "John Doe",
      role: "member"
    }
  end
end
