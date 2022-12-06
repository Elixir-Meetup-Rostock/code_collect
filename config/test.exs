import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :code_collect, CodeCollect.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "code_collect_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :code_collect, CodeCollectWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "VVXwW+3pIOdG9L+Xfd+y3Ugxhmak80Gi7qpL0qdZJflm+U3B1oPD1kZY7NyE3Kab",
  server: false

# In test we don't send emails.
config :code_collect, CodeCollect.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
