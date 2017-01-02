defmodule Sermons.DesiringGod do
  @http_client Application.get_env(:sermons, :http_client)

  def get_sermon(url) do
    @http_client.get(url)
  end

  def parse_sermon_page(html) do
    page = Floki.parse(html)

    sermon = %{
      ministry_name: "Desiring God",
      author: find_author(page),
      title: find_title(page),
      passage: find_passage(page),
      download_url: find_download_url(page)
    }

    case valid?(sermon) do
      true -> {:ok, sermon}
      false -> {:error, "Error parsing sermon"}
    end
  end

  defp find_title(page) do
    Floki.find(page, "h1.resource__title")
    |> Floki.text
    |> String.strip
  end

  defp find_download_url(page) do
    Floki.attribute(page, "a.media-menu__link", "href") |> Enum.at(1)
  end

  defp find_passage(page) do
    Floki.find(page, ".resource__meta")
    |> Floki.find("li > a")
    |> Enum.at(0)
    |> Floki.text
    |> String.replace("–", "-")
  end

  defp valid?(sermon) do
    String.contains?(sermon.passage, ":")
  end

  defp find_author(page) do
    Floki.find(page, ".resource__author")
    |> Floki.find("span")
    |> Enum.at(0)
    |> Floki.text
  end
end
