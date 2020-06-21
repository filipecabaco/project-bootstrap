defmodule ###project_name###.Consumer do
  @moduledoc """
  Collects values from all integrations by User ID
  """
  use GenServer
  def init(services: services), do: {:ok, services}
  def start_link(services), do: GenServer.start_link(__MODULE__, services, name: __MODULE__)

  def handle_call({:get_all, user_id}, _, services) do
    res =
      services
      |> Enum.map(fn mod -> {mod, mod.get(user_id)} end)
      |> Enum.reject(fn {_, res} -> is_nil(res) end)
      |> Enum.into(%{})

    {:reply, {:ok, res}, services}
  end

  def get_all(user_id), do: GenServer.call(Process.whereis(__MODULE__), {:get_all, user_id})

  @callback get(String.t()) :: {:ok, integer()} | {:error, String.t()}
end
