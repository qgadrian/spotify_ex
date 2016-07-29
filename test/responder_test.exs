defmodule GenericMock do
  @behaviour Responder
  use Responder

  def some_endpoint(response) do
    handle_response(response)
  end

  def build_response(body) do
    Helpers.to_struct(Spotify.Playlist, body)
  end

end

defmodule ResponderTest do
  use ExUnit.Case

  describe "handle_responde" do
    test "with 200/201 status and an empty body" do
      assert GenericMock.some_endpoint(success_empty_body) == :ok
    end

    test "with 200/201 status and a body" do
      expected = {:ok, %Spotify.Playlist{name: "foo"}}
      assert GenericMock.some_endpoint(success_with_body) == expected
    end

    test "with 400 status and a body" do
      expected = { :error, %{"error" => "foo" } }
      assert GenericMock.some_endpoint(error) == expected
    end
  end

  defp error do
    {:error, %HTTPoison.Response{ body: Poison.encode!(%{error: "foo"}), status_code: 400 }}
  end

  defp success_empty_body do
    {:ok, %HTTPoison.Response{ body: "", status_code: 200 }}
  end

  defp success_with_body do
    {:ok, %HTTPoison.Response{ body: Poison.encode!(%{name: "foo"}), status_code: 200 }}
  end
end

