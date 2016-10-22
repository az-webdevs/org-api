defmodule Org.Skill do
  use Org.Web, :model

  alias Org.{Repo, User, Language}

  @primary_key false

  schema "skills" do
    belongs_to :users, User, primary_key: true
    belongs_to :languages, Language, primary_key: true

    field :level, :integer, default: 1
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:level])
    |> validate_required([:level])
    |> unique_constraint(:level, name: :skill_unicity)
  end
end
