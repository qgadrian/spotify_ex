defmodule Spotify.Player.Device do
  defstruct ~w[
    id
    is_active
    is_private_session
    is_restricted
    name
    type
    volume_percent
  ]a

  alias Spotify.Client
  use Spotify.Responder
  import Spotify.Helpers

  def build_response(body) do
    to_struct(__MODULE__, body)
  end

  # TODO add url and request functions
  def list_devices_url do
    "https://api.spotify.com/v1/me/player/devices"
  end

  def list_devices(conn) do
    conn |> Client.get(list_devices_url()) |> build_response()
  end
end
