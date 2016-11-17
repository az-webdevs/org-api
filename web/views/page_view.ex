defmodule Org.PageView do
  use Org.Web, :view

  def list_languages(languages) do
    IO.inspect(languages)
    Enum.flat_map(languages, fn(lang) ->
      [{lang
       |> Map.from_struct
       |> Map.take([:id, :name, :title])
       |> Map.values}]
    end)
    |> IO.inspect
  end
end
