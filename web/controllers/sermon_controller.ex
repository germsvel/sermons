defmodule Sermons.SermonController do
  use Sermons.Web, :controller

  def index(conn, %{"q" => q}) do
    query = Sermons.Query.new(q)

    sql_query = Sermons.Sermon.relevant_sermons(query)
    sermons = Repo.all sql_query
    render(conn, "index.html", sermons: sermons, query: query)
  end

  def index(conn, _params) do
    query = %{passage: nil}
    render(conn, "index.html", sermons: [], query: query)
  end
end
