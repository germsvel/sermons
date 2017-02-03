defmodule Sermons.Retrievers.DesiringGodWebsiteTest do
  use Sermons.ModelCase
  alias Sermons.Retrievers.DesiringGodWebsite, as: Retriever

  describe "perform/0" do
    test "retrieves and stores sermons from desiring god's website" do
      Retriever.perform

      sermons = Sermons.Repo.all Sermons.Sermon
      assert length(sermons) == 1
    end
  end
end
