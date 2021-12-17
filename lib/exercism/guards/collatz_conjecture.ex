defmodule Exercism.Guards.CollatzConjecture do
  @moduledoc """
  The Collatz Conjecture or 3x+1 problem can be summarized as follows:

  Take any positive integer n. If n is even, divide n by 2 to get n / 2. If n is odd, multiply n by 3 and add 1 to get 3n + 1. Repeat the process indefinitely. The conjecture states that no matter which number you start with, you will always reach 1 eventually.

  Given a number n, return the number of steps required to reach 1.

  ### Examples

  Starting with n = 12, the steps would be as follows:

  12
  6
  3
  10
  5
  16
  8
  4
  2
  1

  Resulting in 9 steps. So for input n = 12, the return value would be 9.
  """

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when input >= 1, do: do_calc(input, 0)

  defp do_calc(1, steps), do: steps

  defp do_calc(input, steps) when rem(input, 2) == 0, do: do_calc(div(input, 2), steps + 1)

  defp do_calc(input, steps), do: do_calc(input * 3 + 1, steps + 1)
end
