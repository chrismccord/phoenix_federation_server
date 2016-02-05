defmodule PhoenixFederationServer.PubSubChannel do
  use PhoenixFederationServer.Web, :channel
  require Logger

  def join("pubsub", params, socket) do
    Logger.debug "join from #{inspect params}"
    socket.endpoint.subscribe(self(), direct_topic(params["node_name"]))
    {:ok, socket}
  end

  def handle_in("direct_broadcast", payload, socket) do
    socket.endpoint.broadcast!(direct_topic(payload["node_name"]), "broadcast", %{
      topic: payload["topic"],
      conn_ref: payload["conn_ref"],
      msg: payload["msg"],
    })
  end

  def handle_in("broadcast", payload, socket) do
    broadcast!(socket, "broadcast", %{
      topic: payload["topic"],
      conn_ref: payload["conn_ref"],
      msg: payload["msg"],
    })
    {:noreply, socket}
  end

  def direct_topic(node_name) do
    "pubsub:" <> node_name
  end
end
