defmodule Sermons.Workers.ScheduledWorker do
  @moduledoc """
  A behavior module used for recurrent tasks.

  Modules using behavior must define schedule/0 as an integer
  representing the length of time in seconds between each
  work performance
  """

  @doc """
  Invoked to determine when to schedule next task.

  Return then number of seconds you want to wait until the
  next task is executed.
  """
  @callback schedule() :: number

  defmacro __using__(_) do
    quote do
      @behaviour Sermons.Workers.ScheduledWorker
      use GenServer

      def start_link(module_name) do
        GenServer.start_link(__MODULE__, module_name, name: module_name)
      end

      def init(module_name) do
        schedule_work()
        {:ok, module_name}
      end

      def handle_info(:work, module_name) do
        apply(module_name, :perform, [])
        schedule_work()
        {:noreply, module_name}
      end

      defp schedule_work do
        Process.send_after(self(), :work, schedule())
      end

      defp schedule do
       raise "attempted to schedule ScheduledWorker but no schedule/0 clause was provided"
      end

      defoverridable [schedule: 0]
    end
  end
end
