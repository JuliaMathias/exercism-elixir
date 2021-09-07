defmodule Exercism.Booleans.Year do
  @moduledoc """
  Given a year, report if it is a leap year.

  The tricky thing here is that a leap year in the Gregorian calendar occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400

  For example, 1997 is not a leap year, but 1996 is. 1900 is not a leap year, but 2000 is.
  """

  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    case divisible_by_4?(year) do
      true ->
        cond do
          divisible_by_100?(year) && divisible_by_400?(year) -> true
          divisible_by_100?(year) -> false
          true -> true
        end

      false ->
        false
    end
  end

  defp divisible_by_4?(year), do: if(rem(year, 4) == 0, do: true, else: false)

  defp divisible_by_100?(year), do: if(rem(year, 100) == 0, do: true, else: false)

  defp divisible_by_400?(year), do: if(rem(year, 400) == 0, do: true, else: false)
end
