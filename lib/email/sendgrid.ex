defmodule ###project_name###.Email.Sendgrid do
  @moduledoc """
  Handles email logic for ###project_name### using Sendgrid
  """
  @behaviour ###project_name###.Email
  @from_email "dev@###project_name_lower_case###.dev"
  @body File.read!("./priv/static/email.html")
  @url_pattern "###URL###"
  use Tesla, only: [:post], docs: false
  adapter(Tesla.Adapter.Mint)

  plug(Tesla.Middleware.Logger, log_level: :debug)

  plug(Tesla.Middleware.Headers, [])

  plug(Tesla.Middleware.BaseUrl, "https://api.sendgrid.com/v3/")

  plug(Tesla.Middleware.JSON)

  def send_confirmation_email(email, code) do
    body = %{
      "personalizations" => [
        %{
          "to" => [%{"email" => email}],
          "subject" => "Please verify address"
        }
      ],
      "subject" => "Please verify address",
      "to" => [%{"email" => email}],
      "from" => %{"email" => @from_email},
      "content" => [
        %{
          "type" => "text/html",
          "value" => String.replace(@body, @url_pattern, build_code_url(code))
        }
      ]
    }

    {:ok, %{body: body}} =
      post("/mail/send", body, headers: [{"Authorization", "Bearer #{api_key()}"}])

    handle_response(body)
  end

  defp handle_response(nil), do: :ok

  defp handle_response(%{"errors" => [%{"message" => "Does not contain a valid address."}]}),
    do: {:error, :invalid_email}

  defp api_key do
    [api_key: api_key] = Application.get_env(:###project_name_lower_case###, __MODULE__)
    api_key
  end

  defp build_code_url(code) do
    "#{Application.get_env(:###project_name_lower_case###, :base_url)}verify?code=#{code}"
  end
end
