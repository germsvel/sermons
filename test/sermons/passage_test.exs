defmodule Sermons.PassageTest do
  use ExUnit.Case, async: true

  alias Sermons.Passage

  describe "new/1" do
    test "returns an empty struct if no passage is provided" do
      passage = Passage.new(nil)

      assert passage == %Passage{}
    end

    test "returns an empty struct if an empty string is provided" do
      passage = Passage.new("")

      assert passage == %Passage{}
    end

    test "creates a passage struct from the query" do
      passage = Passage.new("Romans 3:23-25")

      assert passage.original == "Romans 3:23-25"
      assert passage.book == "Romans"
      assert passage.from == 3_023
      assert passage.to == 3_025
    end

    test "creates a passage for single verse queries (e.g. Rom 3:23)" do
      passage = Passage.new("Romans 3:23")

      assert passage.original == "Romans 3:23"
      assert passage.book == "Romans"
      assert passage.from == 3_023
      assert passage.to == 3_023
    end

    test "creates a new passage for books with numbers (e.g. 1 Cor 1:13)" do
      passage = Passage.new("1 Corinthians 1:13")

      assert passage.original == "1 Corinthians 1:13"
      assert passage.book == "1 Corinthians"
      assert passage.from == 1_013
      assert passage.to == 1_013
    end

    test "creates a new passage for queries that includes future chapters" do
      passage = Passage.new("Romans 3:23-4:2")

      assert passage.original == "Romans 3:23-4:2"
      assert passage.book == "Romans"
      assert passage.from == 3_023
      assert passage.to == 4_002
    end

    test "creates a new passage for queries whole book searches (e.g. Romans 3)" do
      passage = Passage.new("Romans 3")

      assert passage.original == "Romans 3"
      assert passage.book == "Romans"
      assert passage.from == 3_000
      assert passage.to == 3_500
    end
  end
end
