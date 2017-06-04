defmodule Org.Router do
  use Org.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Org.Plugs.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug Org.Plugs.Auth
  end

  # Scope for OAuth2 routes
  scope "/auth", Org do
    pipe_through :browser

    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/api", Org.Api do
    pipe_through [:api, :authenticated]

    resources "/users", UserController, only: [:index, :show, :update]
    put "/apply/:id", UserController, :apply
  end

  # Scope for authenticated-only routes (user is logged in)
  scope "/", Org do
    pipe_through [:browser, :authenticated]

    get "/apply", PageController, :apply
    put "/apply/:id", UserController, :apply
    get "/thanks", PageController, :thanks
  end

  # Scope for all other routes
  scope "/", Org do
    pipe_through :browser

    get "/", PageController, :home
    get "/signin", PageController, :signin
    resources "/groups", GroupController, only: [:index, :show]
  end
end
