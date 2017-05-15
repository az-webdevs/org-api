defmodule Org.User do
  use Org.Web, :model

  schema "users" do
    field :avatar, :string
    field :bio, :string
    field :blog, :string
    field :company, :string
    # This is the GitHub created_at date
    field :created_at, :string
    field :email, :string
    field :followers, :integer
    field :following, :integer
    field :github_id, :integer
    field :hireable, :boolean, default: false
    field :html_url, :string
    field :location, :string
    field :login, :string
    field :name, :string
    field :public_gists, :integer
    field :public_repos, :integer
    field :role, :string, default: "user"
    field :type, :string
    field :has_applied, :boolean, default: false, null: false
    field :comments, :string

    has_many :groups, Org.Group
    embeds_one :languages, Org.Language

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:avatar, :bio, :blog, :company, :created_at, :email,
        :followers, :following, :hireable, :html_url, :github_id, :location,
        :login, :name, :public_gists, :public_repos, :role, :type, :has_applied,
        :comments
       ])
    |> validate_required([:avatar, :blog, :company, :created_at, :email,
        :followers, :following, :html_url, :github_id, :location, :login,
        :name, :public_gists, :public_repos, :role, :type, :has_applied
       ])
    |> unique_constraint(:github_id)
  end
end
