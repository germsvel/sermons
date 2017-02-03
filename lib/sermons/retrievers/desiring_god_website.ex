defmodule Sermons.Retrievers.DesiringGodWebsite do
  @http_client Application.get_env(:sermons, :http_client)
  @url "http://www.desiringgod.org/scripture/with-messages"

  alias Sermons.DesiringGod

  def perform do
    # get_main_page()
    # |> collect_chapter_urls()
    # |> Enum.each(&visit_urls/1)
    # |> Enum.each(&get_sermon_urls/1).flatten
    # |> Enum.each(&get_sermon/1)
    # |> Enum.each(&parse_sermon_page/1)
    # |> Enum.each(&store_sermon/1)
  end

  def get_main_page do
    @http_client.get(@url)
  end
end
