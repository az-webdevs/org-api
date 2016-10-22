defmodule Org.Language do
  use Org.Web, :model

  schema "languages" do
    field :name, :string
    field :title, :string
    # has_many :user, Org.User
    many_to_many :users, Org.User, join_through: "skills"
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :title])
    |> validate_required([:name, :title])
  end

  def create_or_update!(github_id) do
    changeset(%__MODULE__{}, %{github_id: github_id})
    |> Repo.insert!(conflict_target: :github_id, on_conflict: :nothing)

    __MODULE__
    |> Repo.get_by!(%{github_id: github_id})
  end
end
