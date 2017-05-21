defmodule Org.ErrorViewTest do
  use Org.ConnCase, async: true

  alias Org.ErrorView

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(ErrorView, "404.html", []) ==
           "Page not found"
  end

  test "render 500.html" do
    assert render_to_string(ErrorView, "500.html", []) ==
           "Internal server error"
  end

  test "render 401.json" do
    assert ErrorView.render("401.json", []) == %{error: "Please sign in"}
  end

  test "render 403.json" do
    assert ErrorView.render("403.json", []) == 
      %{error: "You do not have the proper permissions to do that"}
  end

  test "render any other" do
    assert render_to_string(ErrorView, "505.html", []) ==
           "Internal server error"
  end
end
