defmodule Sermons.UserSearchesSermonsTest do
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

  @tag :feature
  test "user sees the name of the sermon, the passage, the author" do
    sermon = insert(:sermon)
    navigate_to "/"

    search_bar
    |> fill_field("Romans 3:23-24")

    submit_element(search_bar)

    sermon_text = first_sermon |> visible_text

    assert sermon_text =~ sermon.title
    assert sermon_text =~ sermon.author
    assert sermon_text =~ sermon.passage
  end

  @tag :feature
  test "user sees links to the source and can download the sermon audio" do
    sermon = insert(:sermon)
    navigate_to "/"

    search_bar
    |> fill_field("Romans 3:23-24")

    submit_element(search_bar)

    source_link = link_for("Source")
    download_link = link_for("Download")

    assert source_link == sermon.source_url
    assert download_link == sermon.download_url
  end

  @tag :feature
  test "search only retrieves relevant sermons" do
    relevant_sermon = insert(:sermon, %{passage: "Romans 3:23-25", from: 3023, to: 3025})
    insert(:sermon, %{passage: "Romans 2:20-28", from: 2020, to: 2028})
    insert(:sermon, %{passage: "Galatians 3:23-25", from: 3023, to: 3025, book: "Galatians"})

    navigate_to "/"

    search_bar
    |> fill_field("Romans 3:23-24")

    submit_element(search_bar)

    sermon_text = first_sermon |> visible_text

    assert length(sermons_list) == 1
    assert sermon_text =~ relevant_sermon.passage
  end

  defp link_for(link_text) do
    first_sermon
    |> find_within_element(:link_text, link_text)
    |> attribute_value("href")
  end

  defp first_sermon do
    Enum.at(sermons_list, 0)
  end

  defp search_bar do
    find_element(:id, "query")
  end

  defp sermons_list do
    find_element(:tag, "tbody")
    |> find_all_within_element(:tag, "tr")
  end
end
