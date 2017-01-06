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

  test "returns {:error, _} when parsing fails" do
    url = "http://www.desiringgod.org/messages/sons-of-liberty-and-joy"

    response = DG.get_sermon(url)
             |> DG.parse_sermon_page

    assert response == {:error, "Error parsing page"}
  end

  test "parses sermon pages that also have video" do
    url = "http://www.desiringgod.org/messages/how-to-know-the-will-of-god"

    {:ok, sermon} = DG.get_sermon(url)
                  |> DG.parse_sermon_page

    assert sermon.ministry_name == "Desiring God"
    assert sermon.author == "John Piper"
    assert sermon.title == "How to Know the Will of God"
    assert sermon.download_url == "http://audio.desiringgod.org/20150927-en-how-to-know-the-will-of-god.mp3?1460400362"
    assert sermon.passage == "Romans 12:1-2"
  end
end
