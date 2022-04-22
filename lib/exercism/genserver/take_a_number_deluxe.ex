defmodule Exercism.Genserver.TakeANumberDeluxe do
  @moduledoc """
  The basic Take-A-Number machine was selling really well, but some users were complaining about its lack of advanced features compared to other models available on the market.

  The manufacturer listened to user feedback and decided to release a deluxe model with more features, and you once again were tasked with writing the software for this machine.

  The new features added to the deluxe model include:
  - Keeping track of currently queued numbers.
  - Setting the minimum and maximum number. This will allow using multiple deluxe Take-A-Number machines for queueing customers to different departments at the same facility, and to tell apart the departments by the number range.
  - Allowing certain numbers to skip the queue to provide priority service to pregnant women and the elderly.
  - Auto shutdown to prevent accidentally leaving the machine on for the whole weekend and wasting energy.

  The business logic of the machine was already implemented by your colleague and can be found in the module `TakeANumberDeluxe.State`. Now your task is to wrap it in a `GenServer`.
  """

  use GenServer

  alias Exercism.Genserver.TakeANumberDeluxe.State

  # Client API

  @doc """
  Use the `GenServer` behaviour in the `TakeANumberDeluxe` module.

  Implement the `start_link/1` function and the necessary `GenServer` callback.

  The argument passed to `start_link/1` is a keyword list. It contains the keys `:min_number` and `:max_number`. The values under those keys need to be passed to the function `TakeANumberDeluxe.State.new/2`.

  If `TakeANumberDeluxe.State.new/2` returns an `{:ok, state}` tuple, the machine should start, using the returned state as its state. If it returns an `{:error, error}` tuple instead, the machine should stop, giving the returned error as the reason for stopping.

  ### Example

  iex> TakeANumberDeluxe.start_link(min_number: 1, max_number: 9)
  {:ok, #PID<0.174.0>}

  iex> TakeANumberDeluxe.start_link(min_number: 9, max_number: 1)
  {:error, :invalid_configuration}
  """
  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    IO.inspect(binding(),
      label: "binding() #{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}",
      limit: :infinity
    )

    IO.puts(" ")
    GenServer.start_link(__MODULE__, init_arg)
  end

  @doc """
  Implement the report_state/1 function and the necessary GenServer callback. The machine should reply to the caller with its current state.

  ### Example

  iex> {:ok, machine} = TakeANumberDeluxe.start_link(min_number: 1, max_number: 10)
  iex> TakeANumberDeluxe.report_state(machine)
  %TakeANumberDeluxe.State{
    max_number: 10,
    min_number: 1,
    queue: %TakeANumberDeluxe.Queue{in: [], out: []},
    auto_shutdown_timeout: :infinity,
  }

  """
  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :report_state)

  @doc """
  Implement the `queue_new_number/1` function and the necessary `GenServer` callback.

  It should call the `TakeANumberDeluxe.State.queue_new_number/1` function with the current state of the machine.

  If `TakeANumberDeluxe.State.queue_new_number/1` returns an  `{:ok, new_number, new_state}` tuple, the machine should reply to the caller with the new number and set the new state as its state. If it returns a `{:error, error}` tuple instead, the machine should reply to the caller with the error and not change its state.

  ### Example

  iex> {:ok, machine} = TakeANumberDeluxe.start_link(min_number: 1, max_number: 10)
  iex> TakeANumberDeluxe.queue_new_number(machine)
  {:ok, 1}

  iex> TakeANumberDeluxe.queue_new_number(machine)
  {:ok, 2}

  iex> TakeANumberDeluxe.queue_new_number(machine)
  {:error, :all_possible_numbers_are_in_use}
  """
  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :queue_new_number)

  @doc """
  Implement the `serve_next_queued_number/2` function and the necessary `GenServer` callback.

  It should call the `TakeANumberDeluxe.State.serve_next_queued_number/2` function with the current state of the machine and its second optional argument, `priority_number`.

  If `TakeANumberDeluxe.State.serve_next_queued_number/2` returns an `{:ok, next_number, new_state}` tuple, the machine should reply to the caller with the next number and set the new state as its state. If it returns a `{:error, error}` tuple instead, the machine should reply to the caller with the error and not change its state.

  ### Example
  iex> {:ok, machine} = TakeANumberDeluxe.start_link(min_number: 1, max_number: 10)
  iex> TakeANumberDeluxe.queue_new_number(machine)
  {:ok, 1}

  iex> TakeANumberDeluxe.serve_next_queued_number(machine)
  {:ok, 1}

    iex> TakeANumberDeluxe.serve_next_queued_number(machine)
  {:error, :empty_queue}

  """
  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil),
    do: GenServer.call(machine, {:serve_next_queued_number, priority_number})

  @doc """
  Implement the `reset_state/1` function and the necessary `GenServer` callback.

  It should call the `TakeANumberDeluxe.State.new/2` function to create a new state using the current state's `min_number` and `max_number`. The machine should set the new state as its state. It should not reply to the caller.

  ### Example

  iex> {:ok, machine} = TakeANumberDeluxe.start_link(min_number: 1, max_number: 10)
  iex> TakeANumberDeluxe.reset_state(machine)
  :ok

  """
  @spec reset_state(pid()) :: :ok
  def reset_state(machine), do: GenServer.cast(machine, :reset_state)

  # Server callbacks

  @impl GenServer
  def init(init_args) do
    min_number = Keyword.get(init_args, :min_number)
    max_number = Keyword.get(init_args, :max_number)
    timeout = Keyword.get(init_args, :auto_shutdown_timeout) || :infinity

    case State.new(min_number, max_number, timeout) do
      {:ok, state} -> {:ok, state, timeout}
      {:error, error} -> {:stop, error}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state),
    do: {:reply, state, state, state.auto_shutdown_timeout}

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case State.queue_new_number(state) do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, new_state.auto_shutdown_timeout}

      error ->
        {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, new_state.auto_shutdown_timeout}

      error ->
        {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    case State.new(state.min_number, state.max_number, state.auto_shutdown_timeout) do
      {:ok, new_state} -> {:noreply, new_state, new_state.auto_shutdown_timeout}
      _ -> {:noreply, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_info(:timeout, state), do: {:stop, :normal, state}

  @impl GenServer
  def handle_info(_, state), do: {:noreply, state, state.auto_shutdown_timeout}
end
