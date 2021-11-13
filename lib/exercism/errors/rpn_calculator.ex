defmodule Exercism.Errors.RPNCalculator do
  @moduledoc """
  While working at Instruments of Texas, you are tasked to work on an experimental Reverse Polish Notation [RPN] calculator written in Elixir. Your team is having a problem with some operations raising errors and crashing the process. You have been tasked to write a function which wraps the operation function so that the errors can be handled more elegantly with idiomatic Elixir code.
  """

  @doc """
  Implement the function calculate!/2 to call the operation function with the stack as the only argument. The operation function is defined elsewhere, but you know that it can either complete successfully or raise an error.

  ### Examples

  iex> stack = []
  iex> operation = fn _ -> :ok end
  iex> RPNCalculator.calculate!(stack, operation)
  :ok

  iex> stack = []
  iex> operation = fn _ -> raise ArgumentError, "An error occurred" end
  iex> RPNCalculator.calculate!(stack, operation)
  ** (ArgumentError) An error occurred
  """
  def calculate!(stack, operation), do: operation.(stack)

  @doc """
  When doing more research you notice that many functions use atoms and tuples to indicate their success/failure. Implement calculate/2 using this strategy.

  ### Examples

  iex> stack = []
  iex> operation = fn _ -> "operation completed" end
  iex> RPNCalculator.calculate(stack, operation)
  {:ok, "operation completed"}

  iex> stack = []
  iex> operation = fn _ -> raise ArgumentError, "An error occurred" end
  iex> RPNCalculator.calculate(stack, operation)
  :error
  """
  @spec calculate(any, any) :: :error | {:ok, any}
  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      _ -> :error
    end
  end

  @doc """
  Some of the errors contain important information that your coworkers need to have to ensure the correct operation of the system. Implement calculate_verbose/2 to pass on the error message. The error is a struct that has a :message field.

  ### Examples

  iex> stack = []
  iex> operation = fn _ -> "operation completed" end
  iex> RPNCalculator.calculate_verbose(stack, operation)
  {:ok, "operation completed"}

  iex> stack = []
  iex> operation = fn _ -> raise ArgumentError, "An error occurred" end
  iex> RPNCalculator.calculate_verbose(stack, operation)
  {:error, "An error occurred"}
  """
  @spec calculate_verbose(any, any) :: {:error, any} | {:ok, any}
  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      e in _ -> {:error, e.message}
    end
  end
end
