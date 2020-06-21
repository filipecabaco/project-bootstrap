defmodule ###project_name###.Email do
  @moduledoc """
  Behaviour for Email client
  """
  alias ###project_name###.Email.Fake

  @callback send_confirmation_email(String.t(), String.t()) ::
              :ok | {:error, :invalid_email}

  def send_confirmation_email(email, code) do
    [{:client, client}] = Application.get_env(:###project_name_lower_case###, __MODULE__)

    if is_nil(client) do
      Fake.send_confirmation_email(email, code)
    else
      client.send_confirmation_email(email, code)
    end
  end
end
