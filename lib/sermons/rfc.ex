defmodule Sermons.Rfc do
  alias Sermons.{Http, FeedReader}

  @feed_url "http://www.redeemerfellowshipchurch.org/feeds/sermons"

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
      ministry_name: "Redeemer Fellowship Church",
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

  defp find_author(page) do
    {speaker, _scripture} = sermon_content_elements(page)

    speaker
    |> String.split("Speaker:")
    |> Enum.at(1)
    |> String.strip()
  end

  defp find_passage(page) do
    {_speaker, scripture}  = sermon_content_elements(page)

    scripture
    |> String.replace("–", "-")
    |> String.split("Scripture:")
    |> Enum.at(1)
    |> String.strip()
  end

  defp sermon_content_elements(page) do
    case parse_sermon_content_elements(page) do
      [_date, speaker, _series, _category, scripture | _] -> {speaker, scripture}
      [_date, speaker, _series, _category] -> {speaker, "Scripture:"}
    end
  end
  defp parse_sermon_content_elements(page) do
    page
    |> Floki.find(".content_area")
    |> Floki.find("p")
    |> Enum.map(&Floki.text/1)
  end

  defp find_title(page) do
    page
    |> Floki.find(".inner_ttle")
    |> Floki.text
  end

  defp find_download_url(page) do
    [_play, download | _] = media_detail_elements(page)

    Floki.attribute(download, "href")
    |> Enum.at(0)
  end

  defp media_detail_elements(page) do
    page
    |> Floki.find(".media.detail")
    |> Floki.find("a")
  end

  defp valid?(response) do
    passage_valid?(response.passage)
  end

  defp passage_valid?(nil), do: false
  defp passage_valid?(passage), do: String.contains?(passage, ":")
end
