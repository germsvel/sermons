defmodule Sermons.DailyWorkerTest do
  use ExUnit.Case, async: true

  alias Sermons.DailyWorker
  alias Mocks.WorkerMock

  test "schedules work to be performed 24 hours after" do
    {:ok, worker} = DailyWorker.start_link(WorkerMock)

    Process.monitor(worker)
  end

  test "reschedules work after finishing work" do

  end
end
