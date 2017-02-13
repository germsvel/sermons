defmodule Sermons.DesiringGod do
  alias Sermons.{Http, FeedReader}

  @root_url "http://www.desiringgod.org"
  @chapters_url "#{@root_url}/scripture/with-messages"
  @feed_url "http://feed.desiringgod.org/messages.rss"

  def get_chapter_urls do
    Http.get(@chapters_url)
    |> Floki.find(".chapters")
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> Enum.map(&prepend_root_url/1)
  end
  defp prepend_root_url(url), do: @root_url <> url

  def get_sermon_urls(chapter_url) do
    Http.get(chapter_url)
    |> Floki.find(".share")
    |> Floki.attribute("data-link")
  end

  def get_sermon_urls_from_feed do
    feed = Http.get(@feed_url) |> FeedReader.parse()

    feed.entries
    |> Enum.map(fn entry -> entry.id end)
  end

  def get_sermon(url) do
    Http.get(url) |> parse_sermon_page(url: url)
  end

  defp parse_sermon_page(html, url: url) do
    page = Floki.parse(html)

    response = %{
      ministry_name: "Desiring God",
      author: find_author(page),
      title: find_title(page),
      passage: find_passage(page),
      download_url: find_download_url(page),
      source_url: url
    }

    validate(response)
  end

  defp validate(response) do
    if valid?(response) do
      {:ok, response}
    else
      {:error, "Error parsing page"}
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
