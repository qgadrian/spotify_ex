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

  use Spotify.Responder
  import Spotify.Helpers

  def build_response(body) do
    to_struct(__MODULE__, body)
  end

  # TODO add url and request functions
end
