defmodule Sermons.UserSearchesSermons do
  use Sermons.FeatureCase
  import Sermons.Factory

  @tag :feature
  test "user sees a list of sermons as a result of search" do
    insert_list(2, :sermon)
    navigate_to "/"

    search_bar
    |> fill_field("Romans 3:23-24")

    submit_element(search_bar)

    assert page_source =~ "Sermons for Romans 3:23-24"
    assert length(sermons_list) == 2
  end

  defp search_bar do
    find_element(:id, "search_query")
  end

  defp sermons_list do
    find_element(:tag, "tbody")
    |> find_all_within_element(:tag, "tr")
  end
end
