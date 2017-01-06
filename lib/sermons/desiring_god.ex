defmodule Sermons.DesiringGod do
  @http_client Application.get_env(:sermons, :http_client)

  def get_sermon(url) do
    @http_client.get(url)
  end

  def parse_sermon_page(html) do
    page = Floki.parse(html)

    response = %{
      ministry_name: "Desiring God",
      author: find_author(page),
      title: find_title(page),
      passage: find_passage(page),
      download_url: find_download_url(page)
    }

    case valid?(response) do
      true -> {:ok, response}
      false -> {:error, "Error parsing page"}
    end
  end

  defp find_title(page) do
    Floki.find(page, "h1.resource__title")
    |> Floki.text
    |> String.strip
  end

  defp find_download_url(page) do
    Floki.find(page, "a.media-menu__link")
    |> Enum.find(&audio_link?(&1))
    |> Floki.attribute("href")
    |> Enum.at(0)
  end
  defp audio_link?(element) do
    element
    |> Floki.text
    |> String.contains?("Audio (MP3)")
  end

  defp find_passage(page) do
    case find_resources(page) do
      [sermon, _topics | _] -> extract_sermon_text(sermon)
      _ -> nil
    end
  end
  defp find_resources(page) do
    Floki.find(page, ".resource__meta")
    |> Floki.find("li > a")
  end
  defp extract_sermon_text(element) do
    element
    |> Floki.text
    |> String.replace("–", "-")
  end

  defp find_author(page) do
    Floki.find(page, ".resource__author")
    |> Floki.find("span")
    |> Enum.at(0)
    |> Floki.text
  end

  defp valid?(response) do
    passage_valid?(response.passage)
  end

  defp passage_valid?(nil), do: false
  defp passage_valid?(passage), do: String.contains?(passage, ":")
end
