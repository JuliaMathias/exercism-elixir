defmodule Exercism.Processes.TakeANumber do
  @moduledoc """
  You are writing an embedded system for a Take-A-Number machine. It is a very simple model. It can give out consecutive numbers and report what was the last number given out.
  """

  @doc """
  Implement the start/0 function. It should spawn a new process that has an initial state of 0 and is ready to receive messages. It should return the process's PID.

  Modify the machine so that it can receive {:report_state, sender_pid} messages. It should send its current state (the last given out ticket number) to sender_pid and then wait for more messages.

  Modify the machine so that it can receive {:take_a_number, sender_pid} messages. It should increase its state by 1, send the new state to sender_pid, and then wait for more messages.

  Modify the machine so that it can receive a :stop message. It should stop waiting for more messages.

  Modify the machine so that when it receives an unexpected message, it ignores it and continues waiting for more messages.

  """
  def start do
    spawn(fn -> loop(0) end)
  end

  defp loop(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        loop(state)

      {:take_a_number, sender_pid} ->
        new_state = state + 1
        send(sender_pid, new_state)
        loop(new_state)

      :stop ->
        nil

      _ ->
        loop(state)
    end
  end
end
