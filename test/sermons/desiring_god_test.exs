defmodule Sermons.DesiringGodTest do
  use ExUnit.Case, async: true
  alias Sermons.DesiringGod, as: DG
  import Sermons.Fixtures

  describe "parse_sermon_page/1" do
    test "parses a sermon page html" do
      page = fixture("www.desiringgod.org/messages/the-true-grace-of-christian-camaraderie", "html")

      {:ok, sermon} = DG.parse_sermon_page(page)

      assert sermon.ministry_name == "Desiring God"
      assert sermon.author == "John Piper"
      assert sermon.title == "The True Grace of Christian Camaraderie"
      assert sermon.download_url == "http://audio.desiringgod.org/20161222-en-the-true-grace-of-christian-camaraderie.mp3?1481924333"
      assert sermon.passage == "1 Peter 5:12-14"
    end

    test "returns {:error, _} when parsing fails" do
      page = fixture("www.desiringgod.org/messages/sons-of-liberty-and-joy", "html")

      response = DG.parse_sermon_page(page)

      assert response == {:error, "Error parsing page"}
    end

    test "parses sermon pages that also have video" do
      page = fixture("www.desiringgod.org/messages/how-to-know-the-will-of-god", "html")

      {:ok, sermon} = DG.parse_sermon_page(page)

      assert sermon.ministry_name == "Desiring God"
      assert sermon.author == "John Piper"
      assert sermon.title == "How to Know the Will of God"
      assert sermon.download_url == "http://audio.desiringgod.org/20150927-en-how-to-know-the-will-of-god.mp3?1460400362"
      assert sermon.passage == "Romans 12:1-2"
    end
  end

  describe "parse_sermons_feed/1" do
    test "returns a feed" do
      page = fixture("feed.desiringgod.org/messages", "rss")

      feed = DG.parse_sermons_feed(page)
      [entry | _] = feed.entries

      assert length(feed.entries) == 2
      assert entry.author == "John Piper"
    end
  end
end
