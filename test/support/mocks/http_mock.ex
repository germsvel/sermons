defmodule Mocks.HttpMock do
  import Sermons.Fixtures

  def get(url) do
    url
    |> parse_file_name
    |> fixture("html")
  end

  defp parse_file_name(url) do
    uri = URI.parse(url)

    uri.path
    |> String.split("/")
    |> Enum.reverse
    |> Enum.at(0)
  end
end
