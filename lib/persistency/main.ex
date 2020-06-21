defmodule ###project_name###.Persistency.Main do
  @moduledoc """
  Handles all queries with main repository
  """
  use Ecto.Repo,
    otp_app: :###project_name_lower_case###,
    adapter: Ecto.Adapters.Postgres
end
