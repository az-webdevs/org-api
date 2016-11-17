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
alias Org.Language

Repo.insert! %Language{name: "es5", title: "ES5"}
Repo.insert! %Language{name: "es6", title: "ES6/ES2015"}
Repo.insert! %Language{name: "es7", title: "ES7/ES2016"}
Repo.insert! %Language{name: "typescript", title: "TypeScript"}
Repo.insert! %Language{name: "purescript", title: "PureScript"}
Repo.insert! %Language{name: "dotnet", title: ".NET"}
Repo.insert! %Language{name: "elixir", title: "Elixir"}
Repo.insert! %Language{name: "elm", title: "Elm"}
Repo.insert! %Language{name: "rails", title: "Ruby on Rails"}
Repo.insert! %Language{name: "python", title: "Python"}
Repo.insert! %Language{name: "php", title: "PHP"}
Repo.insert! %Language{name: "go", title: "Go"}
