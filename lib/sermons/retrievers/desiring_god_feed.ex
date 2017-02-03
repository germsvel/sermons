defmodule Sermons.Retrievers.DesiringGodFeed do
  alias Sermons.Repo
  alias Sermons.Sermon
  alias Sermons.DesiringGod
  alias Sermons.Http

  @feed_url "http://feed.desiringgod.org/messages.rss"

  def perform do
    get_feed() |> store_entries()
  end

  def get_feed do
    Http.get(@feed_url)
  end

  def store_entries(xml) do
    feed = DesiringGod.parse_sermons_feed(xml)

    feed.entries
    |> Stream.map(&parse_entry/1)
    |> Enum.map(&store_sermon/1)
  end

  defp parse_entry(entry) do
    page = Http.get(entry.id)

    case DesiringGod.parse_sermon_page(page) do
      {:ok, sermon} -> add_source_url(sermon, entry.id)
      {:error, _} -> nil
    end
  end

  defp add_source_url(params, url) do
    params |> Map.put(:source_url, url)
  end

  defp store_sermon(nil), do: nil
  defp store_sermon(params) do
    Sermon.changeset(%Sermon{}, params)
    |> Repo.insert
  end
end
