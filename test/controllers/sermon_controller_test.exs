defmodule Sermons.SermonControllerTest do
  use Sermons.ConnCase

  test "lists all entries on index if query is submitted", %{conn: conn} do
    conn = get conn, sermon_path(conn, :index, %{q: "Romans 3:23-24"})

    assert html_response(conn, 200) =~ "Sermons for Romans 3:23-24"
  end

  test "it does not return a list of sermons if no query is submitted" , %{conn: conn} do
    conn = get conn, sermon_path(conn, :index)

    assert html_response(conn, 200) =~ "Search for sermons"
  end
end
