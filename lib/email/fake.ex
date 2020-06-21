defmodule ###project_name###.Email.Fake do
  @moduledoc """
  Handles email logic for ###project_name### using Sendgrid
  """
  @behaviour ###project_name###.Email
  import Logger

  def send_confirmation_email(email, code) do
    debug("Email sent to #{email} with code #{code}")

    if String.contains?(email, "@") do
      :ok
    else
      {:error, :invalid_email}
    end
  end
end
