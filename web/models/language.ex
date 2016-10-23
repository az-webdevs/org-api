defmodule Org.Language do
  use Org.Web, :model

  schema "languages" do
    field :name, :string
    field :title, :string
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
end
