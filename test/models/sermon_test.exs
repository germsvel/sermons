defmodule Sermons.SermonTest do
  use Sermons.ModelCase

  alias Sermons.Sermon

  @valid_attrs %{author: "some content", download_url: "some content", ministry_name: "some content", passage: "some content", source_url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sermon.changeset(%Sermon{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sermon.changeset(%Sermon{}, @invalid_attrs)
    refute changeset.valid?
  end
end
