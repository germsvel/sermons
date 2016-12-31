defmodule Sermons.FeedReader do
  def parse(xml) do
    {:ok, feed, _} = FeederEx.parse(xml)
    feed
  end
end
