defmodule Sermons.Retrievers.DesiringGodWebsite do
  alias Sermons.{Sermon, Repo}
  alias Sermons.DesiringGod, as: DG

  def perform do
    DG.get_chapter_urls()
    |> extract_sermon_urls()
    |> get_sermons()
    |> store_sermons()
  end

  defp extract_sermon_urls(chapter_urls) do
    chapter_urls
    |> Enum.flat_map(&DG.get_sermon_urls/1)
  end

  defp get_sermons(sermon_urls) do
    sermon_urls
    |> Enum.map(&DG.get_sermon/1)
  end

  defp store_sermons(sermon_pages) do
    sermon_pages
    |> Enum.each(&store_sermon/1)
  end

  defp store_sermon({:error, _}), do: nil
  defp store_sermon({:ok, params}) do
    Sermon.changeset(%Sermon{}, params)
    |> Repo.insert
  end
end
