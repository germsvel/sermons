defmodule Sermons.Retrievers.RfcFeedTest do
  use Sermons.ModelCase
  alias Sermons.Retrievers.RfcFeed, as: Retriever

  describe "perform/0" do
    test "retrieves and stores sermons from Redeemer Fellowhip Church's feed" do
      Retriever.perform

      sermons = Sermons.Repo.all Sermons.Sermon
      assert length(sermons) == 1
    end
  end
end
