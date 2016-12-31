defmodule Sermons.Fixtures do
  def fixture(name) do
    {:ok, pid} = File.read("#{File.cwd!}/test/support/fixtures/#{name}.xml")
    pid
  end
end
