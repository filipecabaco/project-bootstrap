defmodule ###project_name###.Web.Errors do
  @derive Jason.Encoder
  @enforce_keys [:opcode, :message]
  defstruct [:opcode, :message]

  @type t() :: %__MODULE__{
          opcode: String.t(),
          message: String.t()
        }

  def unauthorized(), do: %__MODULE__{opcode: "00001", message: "Unauthorized Access"}
  def invalid_email(), do: %__MODULE__{opcode: "00002", message: "Invalid Email"}
  def email_taken(), do: %__MODULE__{opcode: "00003", message: "Email already in use"}
end
