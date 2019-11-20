defmodule Spotify.Player.DeviceTest do
  use ExUnit.Case

  alias Spotify.Player.Device

  test "%Spotify.Player.Device{}" do
    actual = ~w[id is_active is_private_session is_restricted name type volume_percent]a

    expected = %Device{} |> Map.from_struct() |> Map.keys()

    assert actual == expected
  end

  test "build_response/1" do
    response = %{
      "devices" => [
        %{
          "id" => "123",
          "is_active" => true,
          "is_private_session" => false,
          "is_restricted" => false,
          "name" => "So-And-So's Phone",
          "type" => "mobile",
          "volume_percent" => 95
        },
        %{
          "id" => "456",
          "is_active" => true,
          "is_private_session" => false,
          "is_restricted" => false,
          "name" => "So-And-So's Computer",
          "type" => "mobile",
          "volume_percent" => 71
        }
      ]
    }

    actual = Device.build_response(response)

    expected = [
      %Device{
        id: "123",
        is_active: true,
        is_private_session: false,
        is_restricted: false,
        name: "So-And-So's Phone",
        type: "mobile",
        volume_percent: 95
      },
      %Device{
        id: "456",
        is_active: true,
        is_private_session: false,
        is_restricted: false,
        name: "So-And-So's Computer",
        type: "mobile",
        volume_percent: 71
      }
    ]

    assert actual == expected
  end
end
