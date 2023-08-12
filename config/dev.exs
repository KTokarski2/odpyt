import Config

e = &System.get_env(&1)

# Configure your database

config :odpyt, Odpyt.Repo,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  hostname: e.("POSTGRES_HOST"),
  port: e.("POSTGRES_PORT"),
  database: e.("POSTGRES_DB"),
  username: e.("POSTGRES_USER"),
  password: e.("POSTGRES_PASSWORD")

# For development, we disable any cache and enable
# debugging and code reloading.

config :odpyt, OdpytWeb.Endpoint,
  https: [
   port: e.("PORT"),
   cipher_suite: :strong,
   keyfile: e.("KEYFILE_PATH"),
   certfile: e.("CERTFILE_PATH"),
  ],
  secret_key_base: e.("SECRET_KEY"),
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]


# Watch static and templates for browser reloading.
config :odpyt, OdpytWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/odpyt_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

# Enable dev routes for dashboard and mailbox
config :odpyt, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false
