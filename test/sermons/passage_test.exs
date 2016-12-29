defmodule Sermons.PassageTest do
  use ExUnit.Case, async: true

  alias Sermons.Passage

  # ===
  # .new
  # ===
  test ".new creates a query struct from the passage" do
    query = Passage.new("Romans 3:23-25")

    assert query.original == "Romans 3:23-25"
    assert query.book == "Romans"
    assert query.from == 3_023
    assert query.to == 3_025
  end

  test ".new creates a query for single verse passages (e.g. Rom 3:23)" do
    query = Passage.new("Romans 3:23")

    assert query.original == "Romans 3:23"
    assert query.book == "Romans"
    assert query.from == 3_023
    assert query.to == 3_023
  end

  test ".new creates a new query for books with numbers (e.g. 1 Cor 1:13)" do
    query = Passage.new("1 Corinthians 1:13")

    assert query.original == "1 Corinthians 1:13"
    assert query.book == "1 Corinthians"
    assert query.from == 1_013
    assert query.to == 1_013
  end

  test ".new creates a new query for passage that includes future chapters" do
    query = Passage.new("Romans 3:23-4:2")

    assert query.original == "Romans 3:23-4:2"
    assert query.book == "Romans"
    assert query.from == 3_023
    assert query.to == 4_002
  end
end
