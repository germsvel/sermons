require IEx

defmodule Sermons.DailyWorkerTest do
  use ExUnit.Case, async: true

  alias Sermons.DailyWorker
  alias Mocks.WorkerMock

  describe "start_link/1" do
    test "starts a named worker to perform work" do
      {:ok, worker} = DailyWorker.start_link(WorkerMock)

      pid = Process.whereis(WorkerMock)

      assert Process.alive?(worker)
      assert pid == worker
    end
  end

  describe "handle_info/3" do
    test "reschedules work after finishing work" do
      {:ok, worker} = DailyWorker.start_link(WorkerMock)

      send(worker, :work)
      |> IO.inspect

    end
  end
end
