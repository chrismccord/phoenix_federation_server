defmodule PhoenixFederationServer.PageController do
  use PhoenixFederationServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
