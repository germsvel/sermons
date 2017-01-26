defmodule Sermons.SermonTest do
  use Sermons.ModelCase
  import Sermons.Factory

  alias Sermons.Sermon

  describe "changeset/2" do
    test "changeset with valid attributes" do
      valid_attrs = params_for(:sermon)
      changeset = Sermon.changeset(%Sermon{}, valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = Sermon.changeset(%Sermon{}, %{})
      refute changeset.valid?
    end

    test "changeset validates uniqueness of sermon slug" do
      insert(:sermon)
      params = params_for(:sermon)

      {:error, changeset} = Sermon.changeset(%Sermon{}, params)
                          |> Repo.insert

      {error, _} = changeset.errors[:slug]

      assert error == "has already been taken"
    end

    test "changeset generates a slug" do
      params = params_for(:sermon) |> with_title("Christ the King")

      sermon = Sermon.changeset(%Sermon{}, params)
             |> Repo.insert!

      assert sermon.slug == "christ-the-king"
    end

    test "changeset sets book, from and to based on the passage" do
      attrs = %{passage: "Romans 3:23-25"}
      params = params_for(:sermon, attrs)

      sermon = Sermon.changeset(%Sermon{}, params)
             |> Repo.insert!

      assert sermon.book == "Romans"
      assert sermon.to == 3025
      assert sermon.from == 3023
    end
  end

  describe "relevant_sermons/1" do
    test "returns an exact match" do
      sermon = build(:sermon) |> with_verses(3021, 3026) |> insert
      passage = Sermons.Passage.new("Romans 3:21-26")

      sermons = Sermon.relevant_sermons(passage)
              |> Repo.all

      assert length(sermons) == 1
      assert Enum.member?(sermons, sermon)
    end

    test "returns sermons that have a right-match" do
      sermon = build(:sermon) |> to_verse(3026) |> insert
      passage = Sermons.Passage.new("Romans 3:19-26")

      sermons = Sermon.relevant_sermons(passage)
              |> Repo.all

      assert length(sermons) == 1
      assert Enum.member?(sermons, sermon)
    end

    test "returns sermons that have a left-match" do
      sermon = build(:sermon) |> from_verse(3021) |> insert
      passage = Sermons.Passage.new("Romans 3:21-24")

      sermons = Sermon.relevant_sermons(passage)
              |> Repo.all

      assert length(sermons) == 1
      assert Enum.member?(sermons, sermon)
    end

    test "returns sermons that include the passage" do
      sermon = build(:sermon) |> with_verses(3021, 3026) |> insert
      passage = Sermons.Passage.new("Romans 3:22-23")

      sermons = Sermon.relevant_sermons(passage)
              |> Repo.all

      assert length(sermons) == 1
      assert Enum.member?(sermons, sermon)
    end

    test "returns sermons that are included in the passage" do
      sermon = build(:sermon) |> with_verses(3021, 3026) |> insert
      passage = Sermons.Passage.new("Romans 3:19-28")

      sermons = Sermon.relevant_sermons(passage)
              |> Repo.all

      assert length(sermons) == 1
      assert Enum.member?(sermons, sermon)
    end

    test "returns sermons when they are single verse" do
      sermon = build(:sermon) |> from_verse(3023) |> to_verse(3023) |> insert
      passage = Sermons.Passage.new("Romans 3:23")

      sermons = Sermon.relevant_sermons(passage)
              |> Repo.all

      assert length(sermons) == 1
      assert Enum.member?(sermons, sermon)
    end

    test "returns sermons sorted by from and to ascending" do
      sermon1 = build(:sermon) |> with_passage("Romans 3:23-25") |> insert
      sermon2 = build(:sermon) |> with_passage("Romans 3:23-27") |> insert
      sermon3 = build(:sermon) |> with_passage("Romans 3:21-26") |> insert
      passage = Sermons.Passage.new("Romans 3:24")

      sermons = Sermon.relevant_sermons(passage)
              |> Repo.all

      [first, second, third] = sermons
      assert first == sermon3
      assert second == sermon1
      assert third == sermon2
    end
  end
end

