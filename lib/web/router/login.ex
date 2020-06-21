defmodule ###project_name###.Web.Router.Login do
  @moduledoc """
  Endpoints for user login
  """
  use Plug.Router

  alias ###project_name###.Model.User
  alias ###project_name###.Web.Session.Manager

  plug(:match)
  plug(:dispatch)

  get "/" do
    case Manager.Plug.authenticated?(conn) do
      true -> send_resp(conn, 200, "")
      false -> send_resp(conn, 401, "")
    end
  end

  post "/" do
    %{body_params: %{"email" => email, "password" => password}} = conn

    case User.check(email, password) do
      {:ok, user} ->
        conn
        |> Manager.Plug.sign_in(user)
        |> send_resp(200, "")

      {:error, _} ->
        send_resp(conn, 401, "")
    end
  end
end
