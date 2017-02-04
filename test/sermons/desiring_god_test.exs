defmodule Sermons.DesiringGodTest do
  use ExUnit.Case, async: true
  alias Sermons.DesiringGod, as: DG

  describe "get_chapter_urls/1" do
    test "returns a list of chapter urls for which DG has sermons" do
      urls = [h|_t] = DG.get_chapter_urls

      assert length(urls) == 1
      assert h == "http://www.desiringgod.org/scripture/genesis/35/messages"
    end
  end

  describe "get_sermon_urls/1" do
    test "returns a list of sermon urls from a chapter url" do
      url = "http://www.desiringgod.org/scripture/genesis/35/messages"

      urls = [h|_t] = DG.get_sermon_urls(url)

      assert length(urls) == 1
      assert h == "http://www.desiringgod.org/messages/gods-purpose-for-jacob-and-bethlehem"
    end
  end

  describe "get_sermon_urls_from_feed/0" do
    test "returns a list of sermon urls from an rss feed" do
      urls = [h|_t] = DG.get_sermon_urls_from_feed

      assert length(urls) == 2
      assert h == "http://www.desiringgod.org/messages/the-true-grace-of-christian-camaraderie"
    end
  end

  describe "get_sermon/1" do
    test "parses a sermon page html" do
      url = "http://www.desiringgod.org/messages/the-true-grace-of-christian-camaraderie"

      {:ok, sermon} = DG.get_sermon(url)

      assert sermon.ministry_name == "Desiring God"
      assert sermon.author == "John Piper"
      assert sermon.title == "The True Grace of Christian Camaraderie"
      assert sermon.download_url == "http://audio.desiringgod.org/20161222-en-the-true-grace-of-christian-camaraderie.mp3?1481924333"
      assert sermon.passage == "1 Peter 5:12-14"
      assert sermon.source_url == url
    end

    test "returns {:error, _} when parsing fails" do
      url = "http://www.desiringgod.org/messages/sons-of-liberty-and-joy"

      response = DG.get_sermon(url)

      assert response == {:error, "Error parsing page"}
    end

    test "parses sermon pages that also have video" do
      url = "http://www.desiringgod.org/messages/how-to-know-the-will-of-god"

      {:ok, sermon} = DG.get_sermon(url)

      assert sermon.ministry_name == "Desiring God"
      assert sermon.author == "John Piper"
      assert sermon.title == "How to Know the Will of God"
      assert sermon.download_url == "http://audio.desiringgod.org/20150927-en-how-to-know-the-will-of-god.mp3?1460400362"
      assert sermon.passage == "Romans 12:1-2"
      assert sermon.source_url == url
    end
  end
end
