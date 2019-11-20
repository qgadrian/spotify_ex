defmodule Spotify.Player.PlaybackStateTest do
  use ExUnit.Case

  alias Spotify.Player.PlaybackState
  alias Spotify.Player.Device
  alias Spotify.Track

  test "%Spotify.Player.PlaybackState{}" do
    actual = ~w[
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

    expected = %PlaybackState{} |> Map.from_struct() |> Map.keys()

    assert actual == expected
  end

  test "build_response/1" do
    response = %{
      "timestamp" => 1_490_252_122_574,
      "device" => %{
        "id" => "3f228e06c8562e2f439e22932da6c3231715ed53",
        "is_active" => false,
        "is_restricted" => false,
        "name" => "Xperia Z5 Compact",
        "type" => "Smartphone",
        "volume_percent" => 54
      },
      "progress_ms" => "44272",
      "is_playing" => true,
      "currently_playing_type" => "track",
      "actions" => %{
        "disallows" => %{
          "resuming" => true
        }
      },
      "item" => %{},
      "shuffle_state" => false,
      "repeat_state" => "off",
      "context" => %{
        "external_urls" => %{
          "spotify" => "://"
        },
        "href" => "://",
        "type" => "playlist",
        "uri" => "spotify:user:spotify:playlist:49znshcYJROspEqBoHg3Sv"
      }
    }

    actual = PlaybackState.build_response(response)

    expected = %PlaybackState{
      timestamp: 1_490_252_122_574,
      device: %Device{
        id: "3f228e06c8562e2f439e22932da6c3231715ed53",
        is_active: false,
        is_restricted: false,
        name: "Xperia Z5 Compact",
        type: "Smartphone",
        volume_percent: 54
      },
      progress_ms: "44272",
      is_playing: true,
      currently_playing_type: "track",
      actions: %{
        "disallows" => %{
          "resuming" => true
        }
      },
      item: %Track{},
      shuffle_state: false,
      repeat_state: "off",
      context: %{
        "external_urls" => %{
          "spotify" => "://"
        },
        "href" => "://",
        "type" => "playlist",
        "uri" => "spotify:user:spotify:playlist:49znshcYJROspEqBoHg3Sv"
      }
    }

    assert actual == expected
  end
end
