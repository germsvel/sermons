defmodule Sermons.SermonController do
  use Sermons.Web, :controller

  alias Sermons.Query

  def index(conn, %{"q" => q}) do
    query = %{passage: q}
    sermons = Query.new(q)
            |> Query.run
    render(conn, "index.html", sermons: sermons, query: query)
  end

  def index(conn, _params) do
    query = %{passage: nil}
    render(conn, "index.html", sermons: [], query: query)
  end
end
