defmodule Sermons.Retrievers.DesiringGodWebsite do
  alias Sermons.Sermon
  alias Sermons.Repo
  alias Sermons.DesiringGod, as: DG

  def perform do
    DG.get_chapter_urls()
    |> Enum.flat_map(&DG.get_sermon_urls/1)
    |> Enum.map(&DG.get_sermon/1)
    |> Enum.each(&store_sermon/1)
  end

  defp store_sermon({:error, _}), do: nil
  defp store_sermon({:ok, params}) do
    Sermon.changeset(%Sermon{}, params)
    |> Repo.insert
  end
end
