defmodule Org.Repo.Migrations.CreateLanguage do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :name, :string, null: false
      add :title, :string, null: false
    end
  end
end
