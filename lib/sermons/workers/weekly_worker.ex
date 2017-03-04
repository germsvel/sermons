defmodule Sermons.Workers.WeeklyWorker do
  use Sermons.Workers.ScheduledWorker

  @doc """
  7 days in seconds.
  """
  def schedule do
    7 * 24 * 60 * 60 * 1000
  end
end
