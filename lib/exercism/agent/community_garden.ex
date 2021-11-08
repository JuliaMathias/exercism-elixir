defmodule Exercism.Agent.CommunityGarden do
  @moduledoc """
  Your community association has asked you to implement a simple registry application to manage the community garden registrations. The Plot struct has already been provided for you.

  """

  alias Exercism.Agent.Plot

  @spec start(any) :: {:error, any} | {:ok, pid}
  @doc """
  Implement the CommunityGarden.start/1 function, it should receive a optional keyword list of options to pass forward to the agent process. The garden's initial state should be initialized to represent an empty collection of plots. It should return an :ok tuple with the garden's pid.

  ### Example

  iex> {:ok, pid} = CommunityGarden.start()
  {:ok, pid}
  """
  def start(opts \\ []), do: Agent.start(fn -> opts end)

  @spec list_registrations(pid) :: any
  @doc """
  Implement the CommunityGarden.list_registrations/1 function. It should receive the pid for the community garden. It should return a list of the stored plots that are registered.

  ### Example

  iex> {:ok, pid} = CommunityGarden.start()
  iex> CommunityGarden.list_registrations(pid)
  []
  """
  def list_registrations(pid), do: Agent.get(pid, fn state -> state end)

  @doc """
  Implement the CommunityGarden.register/2 function. It should receive the pid for the community garden and a name to register the plot. It should return the Plot struct with the plot's id and person registered to when it is successful.

  ### Example

  iex> {:ok, pid} = CommunityGarden.start()
  iex> CommunityGarden.register(pid, "Emma Balan")
  %Plot{plot_id: 1, registered_to: "Emma Balan"}
  iex> CommunityGarden.list_registrations(pid)
  [%Plot{plot_id: 1, registered_to: "Emma Balan"}]
  """
  def register(pid, register_to) do
    Agent.update(pid, fn state -> state ++ [%Plot{plot_id: 1, registered_to: register_to}] end)

    list_registrations(pid) |> List.first()
  end

  def release(pid, plot_id) do
    # Please implement the release/2 function
  end

  def get_registration(pid, plot_id) do
    # Please implement the get_registration/2 function
  end
end
