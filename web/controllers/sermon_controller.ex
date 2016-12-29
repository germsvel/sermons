defmodule Sermons.SermonController do
  use Sermons.Web, :controller

  def index(conn, %{"q" => q}) do
    query = Sermons.Passage.new(q)
          |> Sermons.Sermon.relevant_sermons
    sermons = Repo.all query
    render(conn, "index.html", sermons: sermons, query: q)
  end

  def index(conn, _params) do
    render(conn, "index.html", sermons: [], query: nil)
  end
end
