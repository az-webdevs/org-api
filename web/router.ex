defmodule Org.Router do
  use Org.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Org.Plugs.AssignCurrentUser
  end

  pipeline :authenticated do
    plug Org.Plugs.Authenticated
  end

  pipeline :auth_admin do
    plug Org.Plugs.Authenticated
    plug Org.Plugs.Authorized, ["admin"]
  end

  pipeline :auth_member do
    plug Org.Plugs.Authenticated
    plug Org.Plugs.Authorized, ["member", "admin"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Scope for OAuth2 routes
  scope "/auth", Org do
    pipe_through :browser

    get "/:provider", AuthController, :index
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Scope for admin-only routes
  scope "/", Org.Admin do
    pipe_through [:browser, :auth_admin]

    # resources "/users", UserController, except: [:show, :new, :update]
    resources "/groups", GroupController, except: [:index, :show]
  end

  # Scope for member-only routes
  scope "/", Org do
    pipe_through [:browser, :auth_member]

    resources "/users", UserController, only: [:index, :show]
  end

  # Scope for authenticated-only routes (user is logged in)
  scope "/", Org do
    pipe_through [:browser, :authenticated]

    get "/apply", PageController, :apply
    put "/apply/:id", UserController, :apply
    get "/thanks", PageController, :thanks
  end

  scope "/api", Org.Api do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :update]
  end

  # Scope for all other routes
  scope "/", Org do
    pipe_through :browser

    get "/", PageController, :home
    get "/signin", PageController, :signin
    resources "/groups", GroupController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Org do
  #   pipe_through :api
  # end
end
