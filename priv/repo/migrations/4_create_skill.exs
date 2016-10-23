defmodule Org.Repo.Migrations.CreateSkill do
  use Ecto.Migration

  def change do
    create table(:skills, primary_key: false) do
      add :level, :integer, default: 1
      add :user_id, references(:users, on_delete: :nothing), primary_key: true
      add :language_id, references(:languages, on_delete: :nothing), primary_key: true
    end

    create index :skills, [:level]
    create unique_index :skills, [:user_id, :language_id], name: :skill_unicity
  end
end
