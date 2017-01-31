defmodule Sermons.Retrievers.DesiringGodWebsite do
  @http_client Application.get_env(:sermons, :http_client)
  @url "http://www.desiringgod.org/scripture/with-messages"

  def perform do
    get_main_page
  end

  def get_main_page do
    @http_client.get(@url)
  end
end
