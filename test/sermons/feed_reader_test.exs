defmodule Sermons.FeedReaderTest do
  use ExUnit.Case, async: true
  import Sermons.Fixtures

  alias Sermons.FeedReader

  test "parses feed xml" do
    xml = fixture("desiring_god_feed")

    feed = FeedReader.parse(xml)

    assert feed.title == "John Piper Sermons"
    assert length(feed.entries) == 36
  end
end
