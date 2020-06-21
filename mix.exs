defmodule ###project_name###.MixProject do
  use Mix.Project

  def project do
    [
      app: :###project_name_lower_case###,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {###project_name###, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.10.0"},
      {:plug_cowboy, "~> 2.0"},
      {:tesla, "~> 1.3.0"},
      {:mint, "~> 1.0"},
      {:castore, "~> 0.1.0"},
      {:jason, "~> 1.2"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:argon2_elixir, "~> 2.0"},
      {:guardian, "~> 2.0"},
      {:redix, "~>0.11.0"},
      {:credo, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases() do
    [
      "client.compile": [
        """
        cmd cd ./app && \
        npm install && \
        npm run build && \
        mkdir -p ../priv/app/assets && \
        cp -r ./dist/* ../priv/app
        cp -r ./public/assets ../priv/app/assets
        """
      ]
    ]
  end
end
