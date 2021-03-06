defmodule Sermons.FeatureCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that will test the application end to end.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models (e.g. Hound helpers).

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Sermons.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import Sermons.Router.Helpers

      # The default endpoint for testing
      @endpoint Sermons.Endpoint

      hound_session()
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Sermons.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Sermons.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
