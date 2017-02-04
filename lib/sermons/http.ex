defmodule Sermons.Http do
  @http_client Application.get_env(:sermons, :http_client)

  def get(url) do
    @http_client.get(url)
  end
end
