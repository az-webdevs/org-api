defmodule Org.TestHelpers do
  def render_json(view, template, assigns) do
    template
    |> view.render(assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
