defmodule Spotify.Player.PlaybackState do
  defstruct ~w[
    actions
    context
    currently_playing_type
    device
    is_playing
    item
    progress_ms
    repeat_state
    shuffle_state
    timestamp
  ]a

  alias Spotify.Client
  use Spotify.Responder
  import Spotify.Helpers
  alias Spotify.Track
  alias Spotify.Player.Device
  alias Spotify.Player.PlaybackState

  def get_playback_state(conn) do
    conn |> Client.get(get_playback_state_url()) |> handle_response()
  end

  def get_playback_state_url do
    "https://api.spotify.com/v1/me/player"
  end

  def build_response(body) do
    build_playback_state(body)
  end

  defp build_playback_state(body) do
    to_struct(__MODULE__, body)
    |> build_track()
    |> build_device()
  end

  defp build_track(playback_state) do
    %PlaybackState{playback_state | item: to_struct(Track, playback_state.item)}
  end

  defp build_device(playback_state) do
    %PlaybackState{playback_state | device: to_struct(Device, playback_state.device)}
  end
end
