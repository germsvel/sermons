defmodule Sermons.Retrievers.DesiringGodFeed do
  alias Sermons.FeedReader
  alias Sermons.Repo
  alias Sermons.Sermon
  alias Sermons.DesiringGod

  @http_client Application.get_env(:sermons, :http_client)
  @feed_url "http://feed.desiringgod.org/messages.rss"

  def perform do
    get_feed |> store_entries
  end

  def get_feed do
    @http_client.get(@feed_url)
  end

  def store_entries(xml) do
    feed = FeedReader.parse(xml)

    feed.entries
    |> Enum.map(&parse_entry/1)
    |> Enum.reject(fn sermon -> sermon == nil end)
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
    |> Repo.insert
  end
end
