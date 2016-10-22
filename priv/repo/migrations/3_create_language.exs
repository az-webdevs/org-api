defmodule Org.Repo.Migrations.CreateLanguage do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :es5, :boolean, default: false, null: false
      add :es6, :boolean, default: false, null: false
      add :es7, :boolean, default: false, null: false
      add :rails, :boolean, default: false, null: false
      add :dotnet, :boolean, default: false, null: false
      add :python, :boolean, default: false, null: false
      add :php, :boolean, default: false, null: false
      add :elixir, :boolean, default: false, null: false
      add :elm, :boolean, default: false, null: false
      add :typescript, :boolean, default: false, null: false
      add :purescript, :boolean, default: false, null: false
      add :go, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:languages, [:user_id])

  end
end
