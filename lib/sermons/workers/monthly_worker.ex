defmodule Sermons.Workers.MonthlyWorker do
  use Sermons.Workers.ScheduledWorker

  @doc """
  30 days in seconds.
  """
  def schedule do
    30 * 24 * 60 * 60 * 1000
  end
end
