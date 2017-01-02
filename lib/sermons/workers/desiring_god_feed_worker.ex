defmodule Sermons.Workers.DesiringGodFeedWorker do
  alias Sermons.FeedReader
  alias Sermons.Repo
  alias Sermons.Sermon
  alias Sermons.DesiringGod

  def store_entries(xml) do
    feed = FeedReader.parse(xml)

    feed.entries
    |> Enum.map(&parse_entry/1)
    |> Enum.map(&store_sermon/1)
  end

  defp parse_entry(entry) do
    DesiringGod.get_sermon(entry.id)
    |> DesiringGod.parse_sermon_page
    |> add_source_url(entry.id)
  end

  defp add_source_url(sermon, url) do
   %{sermon | source_url: url}
  end

  defp store_sermon(sermon) do
    changeset = Sermon.changeset(sermon)
    Repo.insert! changeset
  end
end
