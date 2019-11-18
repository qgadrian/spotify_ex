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
    case body do
      %{"devices" => devices} -> build_devices(devices)
      booleans_or_error -> booleans_or_error
    end
  end

  def build_devices(devices) do
    Enum.map(devices, &to_struct(__MODULE__, &1))
  end

  def list_devices_url do
    "https://api.spotify.com/v1/me/player/devices"
  end

  def list_devices(conn) do
    conn |> Client.get(list_devices_url()) |> handle_response()
  end
end
