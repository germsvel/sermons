defmodule Sermons.Retrievers.DesiringGodFeed do
  alias Sermons.{Repo, Sermon}
  alias Sermons.DesiringGod, as: DG

  def perform do
    DG.get_sermon_urls_from_feed()
    |> Enum.map(&DG.get_sermon/1)
    |> Enum.map(&store_sermon/1)
  end

  defp store_sermon({:error, _}), do: nil
  defp store_sermon({:ok, params}) do
    Sermon.changeset(%Sermon{}, params)
    |> Repo.insert
  end
end
