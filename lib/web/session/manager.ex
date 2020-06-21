defmodule ###project_name###.Web.Session.Manager do
  @moduledoc """
  Handles creation and management of User sessions
  """
  use Guardian, otp_app: :###project_name_lower_case###

  alias ###project_name###.Model.User

  def subject_for_token(%User{email: email}, _claims) do
    {:ok, email}
  end

  def resource_from_claims(%{"sub" => email}) do
    User.get_by_email(email)
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
