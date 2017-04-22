defmodule Org.Language do
  use Org.Web, :model

  embedded_schema do
    field :es5, :boolean
    field :es6, :boolean
    field :es7, :boolean
    field :rails, :boolean
    field :dotnet, :boolean
    field :python, :boolean
    field :php, :boolean
  end

  @doc """
    Builds a changeset based on a `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:es5, :es6, :es7, :rails, :dotnet, :python, :php])
  end
end
