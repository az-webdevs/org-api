defmodule Org.LanguageTest do
  use Org.ModelCase

  alias Org.Language

  @valid_attrs %{dotnet: true, elixir: true, elm: true, es5: true, es6: true, es7: true, php: true, purescript: true, python: true, rails: true, typescript: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Language.changeset(%Language{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Language.changeset(%Language{}, @invalid_attrs)
    refute changeset.valid?
  end
end
