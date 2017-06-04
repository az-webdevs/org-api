# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Org.Repo.insert!(%Org.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Org.Repo
alias Org.User

for admin <- ["Troy Mullaney", "Kevin Lanni"] do
  Repo.get_by(User, name: admin) ||
    Repo.insert!(%User{name: admin, role: "admin"})
end

for member <- ["Dwyane Wade", "LeBron James"] do
  Repo.get_by(User, name: member) ||
    Repo.insert!(%User{name: member, role: "member"})
end

for user <- ["John Doe", "Jane Doe"] do
  Repo.get_by(User, name: user) ||
    Repo.insert!(%User{name: user, role: "user"})
end
