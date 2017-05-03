defmodule Org.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :title, :string
      add :url, :string
      add :description, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:groups, [:user_id])

  end
end
