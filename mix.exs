defmodule DesignSystem.MixProject do
  use Mix.Project

  @version "0.1.0"
  @github_url "https://github.com/peapescarte/pescarte-design-system"

  def project do
    [
      app: :design_system,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      source_url: @github_url
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {DesignSystem.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bandit, "~> 1.0"},
      {:phoenix, "~> 1.7.12"},
      {:lucide_icons, "~> 1.1"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_storybook, "~> 0.6"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.20.2"},
      {:floki, ">= 0.30.0", only: :test},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:dart_sass, "~> 0.7", runtime: Mix.env() == :dev},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": [
        "sass.install --if-missing",
        "tailwind.install --if-missing",
        "esbuild.install --if-missing"
      ],
      "assets.build": ["sass default", "tailwind design_system", "esbuild design_system"],
      "assets.deploy": [
        "sass default",
        "tailwind design_system --minify",
        "tailwind storybook --minify",
        "esbuild design_system --minify",
        "phx.digest"
      ]
    ]
  end

  defp docs do
    [
      main: "DesignSystem",
      source_ref: "v#{@version}",
      source_url: @github_url,
      extras: ["README.md"]
    ]
  end

  defp description do
    """
    Design System do PEA Pescarte
    """
  end

  defp package do
    %{
      name: "pescarte_design_system",
      files: ~w(lib priv .formatter.exs mix.exs README.md LICENSE),
      licenses: ["BSD-3-Clause"],
      links: %{"GitHub" => @github_url}
    }
  end
end
