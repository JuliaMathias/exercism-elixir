defmodule Exercism.Errors.RPNCalculator.Exception do
  @moduledoc """
  While continuing your work at Instruments of Texas, there is progress being made on the Elixir implementation of the RPN calculator. Your team would like to be able to raise errors that are more specific than the generic errors provided by the standard library. You are doing some research, but you have decided to implement two new errors which implement the Exception Behaviour.
  """
  defmodule DivisionByZeroError do
    @moduledoc """
    Dividing a number by zero produces an undefined result, which the team decides is best represented by an error.

    Implement the DivisionByZeroError module to have the error message: "division by zero occurred"

    ### Example

    iex> raise DivisionByZeroError
    ** (DivisionByZeroError) division by zero occurred
    """
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @moduledoc """
    RPN calculators use a stack to keep track of numbers before they are added. The team represents this stack with a list of numbers (integer and floating-point), e.g.: [3, 4.0]. Each operation needs a specific number of numbers on the stack in order to perform it's calculation. When there are not enough numbers on the stack, this is called a stack underflow error. Implement the StackUnderflowError exception which provides a default message, and optional extra context

    ### Examples

    iex> raise StackUnderflowError
    ** (StackUnderflowError) stack underflow occurred

    iex> raise StackUnderflowError, "when dividing"
    ** (StackUnderflowError) stack underflow occurred, context: when dividing
    """
    defexception message: "stack underflow occurred"

    @impl true
    def exception(context \\ []) do
      case context do
        [] ->
          %__MODULE__{}

        _ ->
          %__MODULE__{message: "stack underflow occurred, context: " <> context}
      end
    end
  end

  @doc """
  Implement the divide/1 function which takes a stack (list of numbers) and:

  - raises stack underflow when the stack does not contain enough numbers
  - raises division by zero when the divisor is 0 (note the stack of numbers is stored in the reverse order)
  - performs the division when no errors are raised

  ### Examples

  iex> RPNCalculator.Exception.divide([])
  ** (StackUnderflowError) stack underflow occurred, context: when dividing

  iex> RPNCalculator.Exception.divide([0, 100])
  ** (DivisionByZeroError) division by zero occurred

  iex> RPNCalculator.Exception.divide([4, 16])
  4
  """
  @spec divide(list) :: integer
  def divide(stack) do
    cond do
      Enum.count(stack) != 2 ->
        raise StackUnderflowError, "when dividing"

      Enum.member?(stack, 0) ->
        raise DivisionByZeroError

      true ->
        [first, second] = stack
        div(second, first)
    end
  end
end
