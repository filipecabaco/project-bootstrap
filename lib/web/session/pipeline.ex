defmodule ###project_name###.Web.Session.Pipeline do
  @moduledoc """
  Session Plug Pipeline handling session verification of cliams
  """
  use Guardian.Plug.Pipeline,
    otp_app: :###project_name_lower_case###,
    error_handler: ###project_name###.Web.Session.ErrorHandler,
    module: ###project_name###.Web.Session.Manager

  plug(Guardian.Plug.VerifySession, claims: %{"typ" => "access"})
  plug(Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"})
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
