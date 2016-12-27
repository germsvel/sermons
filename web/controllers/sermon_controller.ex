defmodule Sermons.SermonController do
  use Sermons.Web, :controller

  alias Sermons.Sermon

  def index(conn, %{"search" => %{"query" => q}}) do
    query = %{passage: q}
    sermons = Repo.all(Sermon)
    render(conn, "index.html", sermons: sermons, query: query)
  end

  def index(conn, _params) do
    query = %{passage: nil}
    render(conn, "index.html", sermons: [], query: query)
  end
end
