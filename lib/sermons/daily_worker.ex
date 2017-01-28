defmodule Sermons.DailyWorker do
  use GenServer

  @twenty_four_hours 24 * 60 * 60 * 1000

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def init(module_name) do
    schedule_work()
    {:ok, module_name}
  end

  def handle_info(:work, module_name) do
    module_name.perform()
    schedule_work()
    {:noreply, module_name}
  end

  defp schedule_work do
    Process.send_after(self(), :work, @twenty_four_hours)
  end
end
