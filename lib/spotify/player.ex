defmodule Spotify.Player do
  alias Spotify.Client
  use Spotify.Responder

  def play(conn) do
    conn |> Client.put(play_url()) |> handle_response()
  end

  def play(conn, body) do
    conn |> Client.put(play_url(), body) |> handle_response()
  end

  def play_url do
    "https://api.spotify.com/v1/me/player/play"
  end

  def pause(conn) do
    conn |> Client.put(pause_url()) |> handle_response()
  end

  def pause_url do
    "https://api.spotify.com/v1/me/player/pause"
  end

  def build_response(body), do: body
end
