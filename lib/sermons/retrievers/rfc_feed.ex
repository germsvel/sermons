defmodule Sermons.Retrievers.RfcFeed do
  alias Sermons.{Repo, Sermon, Rfc}

  def perform do
    Rfc.get_sermon_urls_from_feed()
    |> Enum.map(&Rfc.get_sermon/1)
    |> Enum.map(&store_sermon/1)
  end

  defp store_sermon({:error, _}), do: nil
  defp store_sermon({:ok, params}) do
    Sermon.changeset(%Sermon{}, params)
    |> Repo.insert
  end
end
