defmodule Sermons.Workers.DesiringGodFeedWorkerTest do
  use Sermons.ModelCase
  import Sermons.Fixtures
  alias Sermons.Workers.DesiringGodFeedWorker, as: Worker

  test "parses and stores sermons from desiring god's feed" do
    xml = fixture("desiring_god_feed")

    Worker.store_entries(xml)

    sermons = Sermons.Repo.all Sermons.Sermon
    assert length(sermons) == 1
  end
end
