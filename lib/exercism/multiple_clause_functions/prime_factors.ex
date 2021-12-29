defmodule Exercism.MultipleClauseFunctions.PrimeFactors do
  @moduledoc """
  Compute the prime factors of a given natural number.

  A prime number is only evenly divisible by itself and 1.

  Note that 1 is not a prime number.

  ### Example

  What are the prime factors of 60?

  - Our first divisor is 2. 2 goes into 60, leaving 30.
  - 2 goes into 30, leaving 15.
  - 2 doesn't go cleanly into 15. So let's move on to our next divisor, 3.
  - 3 goes cleanly into 15, leaving 5.
  - 3 does not go cleanly into 5. The next possible factor is 4.
  - 4 does not go cleanly into 5. The next possible factor is 5.
  - 5 does go cleanly into 5.
  - We're left only with 1, so now, we're done.

  Our successful divisors in that computation represent the list of prime factors of 60: 2, 2, 3, and 5.

  You can check this yourself:

  - 2 * 2 * 3 * 5
  - = 4 * 15
  - = 60
  - Success!

  ### Slow tests

  One or several of the tests of this exercise have been tagged as `:slow`, because they might take a long time to finish. For this reason, they will not be run on the platform by the automated test runner. If you are solving this exercise directly on the platform in the web editor, you might want to consider downloading this exercise to your machine instead. This will allow you to run all the tests and check the efficiency of your solution.
  """

  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number), do: do_factors_for(number, [], 2)

  defp do_factors_for(1, factors, _possible_factor), do: Enum.reverse(factors)

  defp do_factors_for(number, factors, possible_factor) do
    if rem(number, possible_factor) == 0 do
      new_number = div(number, possible_factor)
      do_factors_for(new_number, [possible_factor | factors], possible_factor)
    else
      do_factors_for(number, factors, possible_factor + 1)
    end
  end
end
