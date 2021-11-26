defmodule Exercism.Links.RPNCalculatorInspection do
  @moduledoc """
  Your work at Instruments of Texas on an experimental RPN calculator continues. Your team has built a few prototypes that need to undergo a thorough inspection, to choose the best one that can be mass-produced.

  You want to conduct two types of checks.

  Firstly, a reliability check that will detect inputs for which the calculator under inspection either crashes or doesn't respond fast enough. To isolate failures, the calculations for each input need to be run in a separate process. Linking and trapping exits in the caller process can be used to detect if the calculation finished or crashed.

  Secondly, a correctness check that will check if for a given input, the result returned by the calculator is as expected. Only calculators that already passed the reliability check will undergo a correctness check, so crashes are not a concern. However, the operations should be run concurrently to speed up the process, which makes it the perfect use case for asynchronous tasks.

  """

  @doc """
  Implement the RPNCalculatorInspection.start_reliability_check/2 function. It should take 2 arguments, a function (the calculator), and an input for the calculator. It should return a map that contains the input and the PID of the spawned process.

  The spawned process should call the given calculator function with the given input. The process should be linked to the caller process.

  ### Example

  iex> RPNCalculatorInspection.start_reliability_check(fn _ -> 0 end, "2 3 +")
   %{input: "2 3 +", pid: #PID<0.169.0>}
  """
  @spec start_reliability_check(function, any) :: %{input: any, pid: pid}
  def start_reliability_check(calculator, input),
    do: %{input: input, pid: spawn_link(fn -> calculator.(input) end)}

  @doc """
  Implement the RPNCalculatorInspection.await_reliability_check_result/2 function. It should take two arguments. The first argument is a map with the input of the reliability check and the PID of the process running the reliability check for this input, as returned by RPNCalculatorInspection.start_reliability_check/2. The second argument is a map that serves an accumulator for the results of reliability checks with different inputs.

  The function should wait for an exit message.

  If it receives an exit message ({:EXIT, from, reason}) with the reason :normal from the same process that runs the reliability check, it should return the results map with the value :ok added under the key input.

  If it receives an exit message with a different reason from the same process that runs the reliability check, it should return the results map with the value :error added under the key input.

  If it doesn't receive any messages matching those criteria in 100ms, it should return the results map with the value :timeout added under the key input.

  ### Example
  send(self(), {:EXIT, pid, :normal})

  iex> RPNCalculatorInspection.await_reliability_check_result(%{input: "5 7 -", pid: pid}, %{})
  %{"5 7 -" => :ok}

  iex> RPNCalculatorInspection.await_reliability_check_result(%{input: "3 2 *", pid: pid}, %{"5 7 -" => :ok})
   %{"5 7 -" => :ok, "3 2 *" => :timeout}
  """
  @spec await_reliability_check_result(%{:input => any, :pid => pid}, map) :: map
  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put_new(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put_new(results, input, :error)
    after
      100 -> Map.put_new(results, input, :timeout)
    end
  end

  @doc """
  Implement the RPNCalculatorInspection.reliability_check/2 function. It should take 2 arguments, a function (the calculator), and a list of inputs for the calculator.

  For every input on the list, it should start the reliability check in a new linked process by using start_reliability_check/2. Then, for every process started this way, it should await its results by using await_reliability_check_result/2.

  Before starting any processes, the function needs to flag the current process to trap exits, to be able to receive exit messages. Afterwards, it should reset this flag to its original value.

  The function should return a map with the results of reliability checks of all the inputs.

  ### Example
  fake_broken_calculator = fn input ->
  if String.ends_with?(input, "*"), do: raise "oops"
  end

  inputs = ["2 3 +", "10 3 *", "20 2 /"]
  iex> RPNCalculatorInspection.reliability_check(fake_broken_calculator, inputs)
  %{
      "2 3 +" => :ok,
      "10 3 *" => :error,
      "20 2 /" => :ok
    }
  """
  @spec reliability_check(function, list) :: map
  def reliability_check(calculator, inputs) do
    trap_flag_before_check = Process.flag(:trap_exit, true)

    inputs
    |> Enum.map(&start_reliability_check(calculator, &1))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    |> tap(fn _ -> Process.flag(:trap_exit, trap_flag_before_check) end)
  end

  @doc """
  Implement the RPNCalculatorInspection.correctness_check/2 function. It should take 2 arguments, a function (the calculator), and a list of inputs for the calculator.

  For every input on the list, it should start an asynchronous task that will call the calculator with the given input. Then, for every task started this way, it should await its results for 100ms.

  ### Example

  fast_cheating_calculator = fn input -> 14 end
  inputs = ["13 1 +", "50 2 *", "1000 2 /"]
  iex> RPNCalculatorInspection.correctness_check(fast_cheating_calculator, inputs)
  [14, 14, 14]
  """
  @spec correctness_check(function, list) :: list
  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Enum.map(&Task.await(&1, 100))
  end
end
