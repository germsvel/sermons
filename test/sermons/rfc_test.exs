defmodule Sermons.RfcTest do
  use ExUnit.Case, async: true
  alias Sermons.Rfc

  describe "get_sermon_urls_from_feed/0" do
    test "returns a list of sermon urls from an rss feed" do
      urls = [h|_t] = Rfc.get_sermon_urls_from_feed()

      assert length(urls) == 249
      assert h == "http://www.redeemerfellowshipchurch.org/sermons/sermon/2017-01-28/the-king-is-lord-of-the-sabbath"
    end
  end

  describe "get_sermon/1" do
    test "parses a sermon page html" do
      url = "http://www.redeemerfellowshipchurch.org/sermons/sermon/2017-01-28/the-king-is-lord-of-the-sabbath"

      {:ok, sermon} = Rfc.get_sermon(url)

      assert sermon.ministry_name == "Redeemer Fellowship Church"
      assert sermon.author == "Chris Bass"
      assert sermon.title == "The King Is Lord of the Sabbath"
      assert sermon.download_url == "http://cpmassets.com/download.php?file=1084&site=488&url=http://s3.amazonaws.com/churchplantmedia-cms/redeemer_fellowship_church/the-king-is-lord-of-the-sabbath.mp3"
      assert sermon.passage == "Matthew 12:1-12:14"
      assert sermon.source_url == url
    end

    test "returns {:error, _} when parsing fails" do
      url = "http://www.redeemerfellowshipchurch.org/sermons/sermon/2016-12-25/jesus-was-born-to-make-all-things-new"

      response = Rfc.get_sermon(url)

      assert response == {:error, "Error parsing page"}
    end
  end
end
