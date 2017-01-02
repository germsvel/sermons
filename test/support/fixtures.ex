defmodule Sermons.Fixtures do
  def fixture(name, extension \\ "xml") do
    File.read!("#{fixtures_path}/#{name}.#{extension}")
  end

  defp fixtures_path do
    "#{File.cwd!}/test/support/fixtures"
  end
end
