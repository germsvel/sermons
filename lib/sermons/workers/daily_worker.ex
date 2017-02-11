defmodule Sermons.Workers.DailyWorker do
  use Sermons.Workers.ScheduledWorker

  @doc """
  24 hours in seconds.
  """
  def schedule do
    24 * 60 * 60 * 1000
  end
end
