defmodule Org.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :github_id, :integer
      add :email, :string
      add :name, :string
      add :login, :string
      add :company, :string
      add :created_at, :string
      add :location, :string
      add :has_applied, :boolean, default: false, null: false
      add :role, :string
      add :comments, :string
      add :avatar, :string
      add :bio, :string
      add :blog, :string
      add :followers, :integer
      add :following, :integer
      add :hireable, :boolean, default: false
      add :html_url, :string
      add :public_gists, :integer
      add :public_repos, :integer
      add :type, :string

      timestamps()
    end
    create unique_index(:users, [:github_id])

  end
end
