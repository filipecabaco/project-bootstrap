defmodule ###project_name###.Web.Session.ErrorHandler do
  @moduledoc """
  Authentication Error Handler used by Guardian
  """
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, _, _opts) do
    send_resp(conn, 401, "Unauthorized")
  end
end
