defmodule Sermons.Router do
  use Sermons.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Sermons do
    pipe_through :browser # Use the default browser stack

    get "/", SermonController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Sermons do
  #   pipe_through :api
  # end
end
