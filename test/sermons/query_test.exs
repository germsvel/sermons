defmodule Sermons.QueryTest do
  use ExUnit.Case, async: true

  alias Sermons.Query

  # ===
  # .new
  # ===
  test ".new creates a query struct from the passage" do
    query = Query.new("Romans 3:23-25")

    assert query.passage == "Romans 3:23-25"
    assert query.book == "Romans"
    assert query.chapter == 3
    assert query.first_verse == 23
    assert query.last_verse == 25
  end

  test ".new creates a query for single verse passages (e.g. Rom 3:23)" do
    query = Query.new("Romans 3:23")

    assert query.passage == "Romans 3:23"
    assert query.book == "Romans"
    assert query.chapter == 3
    assert query.first_verse == 23
    assert query.last_verse == 23
  end

  test ".new creates a new query for books with numbers (e.g. 1 Cor 1:13)"

  # ===
  # .run
  # ===
  test ".run retrieves the passages related to the query" do
    query = Query.new("Romans 3:23")

    assert query.passage == "Romans 3:23"
  end
end
