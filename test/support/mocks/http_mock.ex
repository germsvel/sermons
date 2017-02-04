defmodule Mocks.HttpClientMock do
  import Sermons.Fixtures

  def get(url) do
    {host, path, extension} = parse_url(url)

    create_file_name(host, path)
    |> fixture(extension)
  end

  defp parse_url(url) do
    uri = URI.parse(url)

    {path, extension} = parse_path(uri.path)

    {uri.host, path, extension}
  end

  defp parse_path(path) do
    case String.split(path, ".") do
      [path, extension] -> {path, extension}
      [path] -> {path, "html"}
    end
  end

  defp create_file_name(host, path) do
    "#{host}#{path}"
  end
end
