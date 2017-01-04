defmodule Sermons.Workers.DesiringGodFeedWorkerTest do
  use Sermons.ModelCase
  alias Sermons.Workers.DesiringGodFeedWorker, as: Worker

  test "retrieves and stores sermons from desiring god's feed" do
    Worker.get_feed
    |> Worker.store_entries

    sermons = Sermons.Repo.all Sermons.Sermon
    assert length(sermons) == 1
  end
end
