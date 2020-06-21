defmodule ###project_name###.Persistency.Keys do
  @moduledoc """
  Persistency layer responsible for storing of key value elements
  """
  @spec store(String.t(), String.t(), integer() | nil) :: :ok
  def store(key, value \\ "", ttl \\ nil) do
    {:ok, _} = Redix.command(conn(), ["SET", key, value])

    if ttl do
      {:ok, _} = Redix.command(conn(), ["EXPIRE", key, ttl])
    end

    :ok
  end

  @spec get(String.t()) :: {:ok, String.t()} | {:ok, nil}
  def get(key) do
    {:ok, _} = Redix.command(conn(), ["GET", key])
  end

  @spec del(String.t()) :: :ok
  def del(key) do
    {:ok, _} = Redix.command(conn(), ["DEL", key])
    :ok
  end

  def conn, do: Process.whereis(Redix)
end
