defmodule Sermons.DesiringGodTest do
  use ExUnit.Case, async: true
  alias Sermons.DesiringGod, as: DG

  test "parses a sermon page html" do
    url = "http://www.desiringgod.org/messages/the-true-grace-of-christian-camaraderie"
    {:ok, sermon} = DG.get_sermon(url)
                  |> DG.parse_sermon_page

    assert sermon.ministry_name == "Desiring God"
    assert sermon.author == "John Piper"
    assert sermon.title == "The True Grace of Christian Camaraderie"
    assert sermon.download_url == "http://audio.desiringgod.org/20161222-en-the-true-grace-of-christian-camaraderie.mp3?1481924333"
    assert sermon.passage == "1 Peter 5:12-14"
  end
end
