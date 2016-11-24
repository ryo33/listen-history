defmodule Musiclog.Router do
  use Musiclog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do  
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Musiclog do
    pipe_through [:browser, :browser_auth]

    get "/", PlayController, :index
    resources "/users", UserController, only: [:index, :show, :edit, :update]
    resources "/artists", ArtistController, only: [:index, :show]
    resources "/songs", SongController, only: [:index, :show]
    resources "/plays", PlayController, only: [:index, :show, :delete]

    get "/api-key", UserController, :api_key
    post "/api-key/update", UserController, :update_api_key

    get "/login", AuthController, :login_page
    post "/auth/login", AuthController, :login
    get "/logout", AuthController, :delete

    get "/auth/:provider", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback
    post "/auth/create", AuthController, :create
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Musiclog do
    pipe_through [:api, :api_auth]
    put "/users/:user", APIController, :login
    post "/users/:user/play", APIController, :play
    delete "/users/:user", APIController, :logout
  end
end
