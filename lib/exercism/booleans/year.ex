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
    (divisible_by?(year, 4) and not divisible_by?(year, 100)) or divisible_by?(year, 400)
  end

  defp divisible_by?(year, divider), do: rem(year, divider) == 0
end
