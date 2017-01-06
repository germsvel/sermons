defmodule Sermons.Workers.DesiringGodFeedWorker do
  alias Sermons.FeedReader
  alias Sermons.Repo
  alias Sermons.Sermon
  alias Sermons.DesiringGod

  @http_client Application.get_env(:sermons, :http_client)
  @feed_url "http://feed.desiringgod.org/messages.rss"

  def get_feed do
    @http_client.get(@feed_url)
  end

  def store_entries(xml) do
    feed = FeedReader.parse(xml)

    feed.entries
    |> Enum.map(&parse_entry/1)
    |> Enum.reject(fn sermon -> sermon == nil end)
    |> Enum.map(&set_passage/1)
    |> Enum.map(&store_sermon/1)
  end

  defp parse_entry(entry) do
    page = DesiringGod.get_sermon(entry.id)

    case DesiringGod.parse_sermon_page(page) do
      {:ok, sermon} -> add_source_url(sermon, entry.id)
      {:error, _} -> nil
    end
  end

  defp add_source_url(params, url) do
    params |> Map.put(:source_url, url)
  end

  defp store_sermon(params) do
    Sermon.changeset(%Sermon{}, params)
    |> Repo.insert!
  end

  defp set_passage(params) do
    passage = Sermons.Passage.new(params.passage)

    params
    |> Map.put(:book, passage.book)
    |> Map.put(:from, passage.from)
    |> Map.put(:to, passage.to)
  end
end
