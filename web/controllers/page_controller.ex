defmodule Sermons.PageController do
  use Sermons.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
