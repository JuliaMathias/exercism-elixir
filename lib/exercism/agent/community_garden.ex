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

  @spec register(pid, any) :: any
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

  @spec release(pid, any) :: :ok
  @doc """
  Implement the CommunityGarden.release/2 function. It should receive the pid and id of the plot to be released. It should return :ok on success. When a plot is released, the id is not re-used, it is used as a unique identifier only.

  ### Example

  iex> {:ok, pid} = CommunityGarden.start()
  iex> CommunityGarden.register(pid, "Emma Balan")
  %Plot{plot_id: 1, registered_to: "Emma Balan"}
  iex> CommunityGarden.release(pid, 1)
  :ok
  iex> CommunityGarden.list_registrations(pid)
  []
  """
  def release(pid, plot_id) do
    Agent.update(pid, fn state -> Enum.reject(state, fn plot -> plot.plot_id == plot_id end) end)
  end

  @spec get_registration(pid, any) :: %Plot{} | {:not_found, String.t()}
  @doc """
  Implement the CommunityGarden.get_registration/2 function. It should receive the pid and id of the plot to be checked. It should return the plot if it is registered, and :not_found if it is unregistered.

  ### Example

  iex> {:ok, pid} = CommunityGarden.start()
  iex> CommunityGarden.register(pid, "Emma Balan")
  %Plot{plot_id: 1, registered_to: "Emma Balan"}
  iex> CommunityGarden.get_registration(pid, 1)
  %Plot{plot_id: 1, registered_to: "Emma Balan"}
  iex> CommunityGarden.get_registration(pid, 7)
  {:not_found, "plot is unregistered"}
  """
  def get_registration(pid, plot_id) do
    registration =
      Agent.get(pid, fn state -> Enum.find(state, fn plot -> plot.plot_id == plot_id end) end)

    if registration == nil, do: {:not_found, "plot is unregistered"}, else: registration
  end
end
