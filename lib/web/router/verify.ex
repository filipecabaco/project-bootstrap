defmodule ###project_name###.Web.Router.Verify do
  @moduledoc """
  Endpoints used for email verification
  """

  use Plug.Router
  alias ###project_name###.Model.User
  alias ###project_name###.Persistency.Keys

  plug(:match)
  plug(:dispatch)

  get "/" do
    %{query_params: %{"code" => code}} = conn
    :ok = validate_code(code)

    send_resp(conn, 200, "ok")
  end

  defp validate_code(code) do
    case Keys.get(code) do
      {:ok, nil} ->
        {:error, :invalid_token}

      {:ok, _} ->
        {:ok, email} = Keys.get(code)
        :ok = User.update_email_valid(email)
        :ok = Keys.del(code)
    end
  end
end
