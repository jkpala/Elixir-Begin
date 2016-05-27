defmodule Palacios.PageController do
  use Palacios.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
