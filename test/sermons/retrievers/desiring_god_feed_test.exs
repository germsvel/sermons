defmodule Sermons.Retrievers.DesiringGodFeedTest do
  use Sermons.ModelCase
  alias Sermons.Retrievers.DesiringGodFeed, as: Retriever

  describe "perform/0" do
    test "retrieves and stores sermons from desiring god's feed" do
      Retriever.perform

      sermons = Sermons.Repo.all Sermons.Sermon
      assert length(sermons) == 1
    end
  end
end
