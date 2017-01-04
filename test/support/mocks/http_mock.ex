defmodule Mocks.HttpMock do
  import Sermons.Fixtures

  def get(url) do
    {path, extension} = parse_path(url)

    path
    |> parse_file_name
    |> fixture(extension)
  end

  defp parse_path(url) do
    uri = URI.parse(url)

    case String.split(uri.path, ".") do
      [path, extension] -> {path, extension}
      [path] -> {path, "html"}
    end
  end

  defp parse_file_name(path) do
    path
    |> String.split("/")
    |> Enum.reverse
    |> Enum.at(0)
  end
end
