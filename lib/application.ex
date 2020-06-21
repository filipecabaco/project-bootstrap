defmodule ###project_name### do
  @moduledoc """
  Main application
  """
  require Logger
  use Application

  def start(_type, _args) do
    port = (System.get_env("PORT") || "4001") |> String.to_integer()
    Logger.info("Starting at port #{port}")
    [url: redix_url] = Application.get_env(:###project_name_lower_case###, Redix)
    children = [
      {Plug.Cowboy, scheme: :http, plug: ###project_name###.Web.Router.Base, options: [port: port]},
      {Redix, {redix_url, [name: Redix]}},
      {###project_name###.Persistency.Main, []},
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

end
