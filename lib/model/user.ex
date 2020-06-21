defmodule ###project_name###.Model.User do
  @moduledoc """
  User model
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias ###project_name###.Model.User
  alias ###project_name###.Persistency.Keys
  alias ###project_name###.Persistency.Main
  @type t :: %User{}

  # One day TTL
  @key_ttl 60 * 60 * 24
  @email_regex ~r/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

  schema "user" do
    field(:email, :string)
    field(:external_id, Ecto.UUID, autogenerate: true)
    field(:password, :string)
    field(:valid_email, :boolean, default: false)
    timestamps()
  end

  @spec changeset(
          User.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :valid_email])
    |> validate_required([:email, :password, :valid_email])
    |> validate_format(:email, @email_regex)
    |> unique_constraint([:email])
  end

  @spec new(String.t(), String.t()) ::
          {:ok, User.t()} | {:error, :invalid_email} | {:error, :email_being_used}
  def new(email, password) do
    password = Argon2.hash_pwd_salt(password)

    with user <- changeset(%User{}, %{email: email, password: password}),
         {:ok, user} <- Main.insert(user),
         code <- Base.encode32(:crypto.strong_rand_bytes(15)),
         :ok <- Keys.store(code, email, @key_ttl),
         :ok <- ###project_name###.Email.send_confirmation_email(email, code) do
      {:ok, user}
    else
      {:error, :invalid_email} ->
        {:error, :invalid_email}
      {:error, %{errors: [email: {"has invalid format",_}]}} ->
        {:error, :invalid_email}
      {:error, %{errors: [email: {"has already been taken",_}]}} ->
        {:error, :email_being_used}
    end
  end

  @spec update_email_valid(String.t()) :: :ok
  def update_email_valid(email) do
    {:ok, user} = get_by_email(email)
    changeset = changeset(user, %{valid_email: true})
    {:ok, _} = Main.update(changeset)
    :ok
  end

  @spec get_by_email(String.t()) :: {:error, :unauthorized} | {:ok, User.t()}
  def get_by_email(email) do
    case Main.get_by(User, email: email) do
      nil -> {:error, :unauthorized}
      u -> {:ok, u}
    end
  end

  @spec check(String.t(), String.t()) :: {:ok, User.t()} | {:error, :unauthorized}
  def check(email, password_to_chk) do
    with {:ok, user} <- get_by_email(email),
         :ok <- email_check(user),
         :ok <- password_check(user, password_to_chk) do
      {:ok, user}
    else
      err -> err
    end
  end

  defp email_check(%User{valid_email: true}), do: :ok
  defp email_check(%User{valid_email: false}), do: {:error, :verify_email}

  defp password_check(%User{password: password}, password_to_check) do
    if Argon2.verify_pass(password_to_check, password) do
      :ok
    else
      {:error, :unauthorized}
    end
  end
end
