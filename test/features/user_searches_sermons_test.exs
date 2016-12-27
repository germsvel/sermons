defmodule Sermons.UserSearchesSermons do
  use Sermons.FeatureCase

  alias Sermons.Sermon

  @tag :feature
  test "user sees a list of sermons as a result of search" do
    create_sermons
    navigate_to "/"

    search_bar
    |> fill_field("Romans 3:23-24")

    submit_element(search_bar)

    assert page_source =~ "Sermons for Romans 3:23-24"
    assert length(sermons_list) == 2
  end

  defp create_sermons do
    sermon1 = %Sermon{
      ministry_name: "Desiring God",
      passage: "Romans 3:21-26",
      source_url: "http://www.desiringgod.org/messages/god-vindicated-his-righteousness-in-the-death-of-christ",
      download_url: "https://cdn.desiringgod.org/audio/1992/19920315.mp3?1319695290",
      author: "John Piper"
      }
    Repo.insert! sermon1

    sermon2 = %Sermon{
      ministry_name: "Desiring God",
      passage: "Romans 3:21-26",
      source_url: "http://www.desiringgod.org/messages/the-demonstration-of-gods-righteousness-part-1",
      download_url: "http://audio.desiringgod.org/19990509-en-the-demonstration-of-god-s-righteousness-part-1.mp3?1450907585",
      author: "John Piper"
      }
    Repo.insert! sermon2
  end

  defp search_bar do
    find_element(:id, "search_query")
  end

  defp sermons_list do
    find_element(:tag, "tbody")
    |> find_all_within_element(:tag, "tr")
  end
end
