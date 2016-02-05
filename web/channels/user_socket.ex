defmodule PhoenixFederationServer.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "pubsub", PhoenixFederationServer.PubSubChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(params, socket) do
    IO.puts "CONNECT #{inspect params}"
    {:ok, assign(socket, :node_name, params["node_name"])}
  end

  def id(socket), do: socket.assigns.node_name
end
