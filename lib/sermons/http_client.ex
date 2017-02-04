defmodule Sermons.HttpClient do
  def get(url) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(url)
    body
  end
end
