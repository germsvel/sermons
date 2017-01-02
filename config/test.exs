use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sermons, Sermons.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sermons, Sermons.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "sermons_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :hound, driver: "phantomjs"

# configure modules to be used
config :sermons, :http_client, Mocks.HttpMock
