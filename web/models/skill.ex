defmodule Org.Skill do
  use Org.Web, :model

  alias Org

  schema "skills" do
    field :level, :integer, default: 1
    belongs_to :users, Org.User, primary_key: true
    belongs_to :languages, Org.Language, primary_key: true

    timestamps()
  end

  @primary_key false

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:level, :user_id, :language_id])
    |> validate_required([:level])
    |> unique_constraint(:level, name: :skill_unicity)
  end
end
