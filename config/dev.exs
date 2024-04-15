import Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we can use it
# to bundle .js and .css sources.
config :design_system, DesignSystemWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "nJLr+IeB8EoRbDjVal11ScuMcp0RZC+S7+tBkkWTyHr/T41o3FdjYyz2JewFV3er",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:design_system, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:design_system, ~w(--watch)]},
    storybook_tailwind: {Tailwind, :install_and_run, [:storybook, ~w(--watch)]}
  ]

# Watch static and templates for browser reloading.
config :design_system, DesignSystemWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"storybook/.*(exs)$",
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/design_system_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

# Enable dev routes for dashboard and mailbox
config :design_system, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  debug_heex_annotations: true,
  enable_expensive_runtime_checks: true
