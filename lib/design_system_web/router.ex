defmodule DesignSystemWeb.Router do
  use DesignSystemWeb, :router

  import PhoenixStorybook.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DesignSystemWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    storybook_assets()
  end

  scope "/", DesignSystemWeb do
    pipe_through :browser
    live_storybook "/", backend_module: DesignSystemWeb.Storybook
  end
end
