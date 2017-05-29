defmodule Org.User.Permissions do
  import Ecto.Query

  alias Org.User

  def limit_for(User, "admin"), do: User
  def limit_for(User, "member"), do: where(User, [u], u.role != "user")
  def limit_for(User, _role), do: where(User, false)

  def authorize!(user, :update, %{role: "admin"}),
    do: user
  def authorize!(user, :update, %{role: "member"} = current_user),
    do: if current_user.id == user.id, do: user, else: raise Org.Forbidden
  def authorize!(_user, :update, _current_user),
    do: raise Org.Forbidden
end
