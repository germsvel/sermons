defmodule Sermons.SermonTest do
  use Sermons.ModelCase
  import Sermons.Factory

  alias Sermons.Sermon

  test "changeset with valid attributes" do
    valid_attrs = params_for(:sermon)
    changeset = Sermon.changeset(%Sermon{}, valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sermon.changeset(%Sermon{}, %{})
    refute changeset.valid?
  end

  test ".relevant_sermons returns an exact match" do
    sermon = build(:sermon) |> with_verses(3021, 3026) |> insert
    passage = Sermons.Passage.new("Romans 3:21-26")

    sermons = Sermon.relevant_sermons(passage)
            |> Repo.all

    assert length(sermons) == 1
    assert Enum.member?(sermons, sermon)
  end

  test ".relevant_sermons returns sermons that have a right-match" do
    sermon = build(:sermon) |> to_verse(3026) |> insert
    passage = Sermons.Passage.new("Romans 3:19-26")

    sermons = Sermon.relevant_sermons(passage)
            |> Repo.all

    assert length(sermons) == 1
    assert Enum.member?(sermons, sermon)
  end

  test ".relevant_sermons returns sermons that have a left-match" do
    sermon = build(:sermon) |> from_verse(3021) |> insert
    passage = Sermons.Passage.new("Romans 3:21-24")

    sermons = Sermon.relevant_sermons(passage)
            |> Repo.all

    assert length(sermons) == 1
    assert Enum.member?(sermons, sermon)
  end

  test ".relevant_sermons returns sermons that include the passage" do
    sermon = build(:sermon) |> with_verses(3021, 3026) |> insert
    passage = Sermons.Passage.new("Romans 3:22-23")

    sermons = Sermon.relevant_sermons(passage)
            |> Repo.all

    assert length(sermons) == 1
    assert Enum.member?(sermons, sermon)
  end

  test ".relevant_sermons returns sermons that are included in the passage" do
    sermon = build(:sermon) |> with_verses(3021, 3026) |> insert
    passage = Sermons.Passage.new("Romans 3:19-28")

    sermons = Sermon.relevant_sermons(passage)
            |> Repo.all

    assert length(sermons) == 1
    assert Enum.member?(sermons, sermon)
  end

  test ".relevant_sermons returns sermons when they are single verse" do
    sermon = build(:sermon) |> from_verse(3023) |> to_verse(3023) |> insert
    passage = Sermons.Passage.new("Romans 3:23")

    sermons = Sermon.relevant_sermons(passage)
            |> Repo.all

    assert length(sermons) == 1
    assert Enum.member?(sermons, sermon)
  end

  test ".relevant_sermons returns sermons sorted by from and to ascending" do
    sermon1 = build(:sermon) |> with_verses(3023, 3025) |> insert
    sermon2 = build(:sermon) |> with_verses(3023, 3027) |> insert
    sermon3 = build(:sermon) |> from_verse(3021) |> insert
    passage = Sermons.Passage.new("Romans 3:24")

    sermons = Sermon.relevant_sermons(passage)
            |> Repo.all

    [first, second, third] = sermons
    assert first == sermon3
    assert second == sermon1
    assert third == sermon2
  end
end

