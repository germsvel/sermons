defmodule Mix.Tasks.Sermons.ScrapeSite do
  use Mix.Task
  alias Sermons.Retrievers.DesiringGodWebsite

  @shortdoc "Triggers perform/0 on a website retriever."

  def run(["desiring_god"]) do
    start_app()
    DesiringGodWebsite.perform
  end

  def run(_) do
    Mix.shell.error("You must provide the name of the website to scrape. E.g. desiring_god")
  end

  defp start_app do
    Mix.Task.run "app.start"
  end
end
