defmodule ###project_name###.Web.Router.Register do
  @moduledoc """
  Endpoints for user registration
  """
  use Plug.Router

  alias ###project_name###.Model.User
  alias ###project_name###.Web.Errors

  plug(:match)
  plug(:dispatch)

  post "/" do
    %{body_params: %{"email" => email, "password" => password}} = conn

    case User.new(email, password) do
      {:ok, %User{}} -> send_resp(conn, 200, "")
      {:error, :invalid_email} -> send_resp(conn, 400, Jason.encode!(Errors.invalid_email()))
      {:error, :email_being_used} -> send_resp(conn, 400, Jason.encode!(Errors.email_taken()))
    end
  end
end
