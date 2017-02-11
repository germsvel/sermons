defmodule Sermons.RetrievalSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(Sermons.Workers.DailyWorker, [Sermons.Retrievers.DesiringGodFeed]),
      worker(Sermons.Workers.MonthlyWorker, [Sermons.Retrievers.DesiringGodWebsite])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
