defmodule Palacios.Router do
  use Palacios.Web, :router

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

  scope "/", Palacios do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index    
  
    resources "/pineda", PinedaController
    resources "/formulario", FormularioController
  end

  # Other scopes may use custom stacks.
   scope "/api", Palacios do
     pipe_through :api
     
     resources "/palacios", PalaciosController, except: [:new, :edit]
     resources "/joseluis", JoseluisController, except: [:new, :edit]
   end
end
