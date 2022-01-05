defmodule Exercism.Recursion.RomanNumerals do
  @moduledoc """
  Write a function to convert from normal numbers to Roman Numerals.

  The Romans were a clever bunch. They conquered most of Europe and ruled it for hundreds of years. They invented concrete and straight roads and even bikinis. One thing they never discovered though was the number zero. This made writing and dating extensive histories of their exploits slightly more challenging, but the system of numbers they came up with is still in use today. For example the BBC uses Roman numerals to date their programmes.

  The Romans wrote numbers using letters - I, V, X, L, C, D, M. (notice these letters have lots of straight lines and are hence easy to hack into stone tablets).

  ```
  1  => I
  10  => X
  7  => VII
  ```

  There is no need to be able to convert numbers larger than about 3000. (The Romans themselves didn't tend to go any higher)

  Wikipedia says: Modern Roman numerals ... are written by expressing each digit separately starting with the left most digit and skipping any digit with a value of zero.

  To see this in practice, consider the example of 1990.

  In Roman numerals 1990 is MCMXC:

  1000=M 900=CM 90=XC

  2008 is written as MMVIII:

  2000=MM 8=VIII

  See also: http://www.novaroma.org/via_romana/numbers.html
  """
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> Integer.digits()
    |> Enum.reverse()
    |> List.to_tuple()
    |> from_decimal_to_roman()
  end

  def decimal(number) do
    from_roman_to_decimal(number, 0)
  end

  defp from_decimal_to_roman(numeral) when is_list(numeral), do: List.to_string(numeral)

  defp from_decimal_to_roman(number) do
    numeral =
      case elem(number, 0) do
        1 -> "I"
        2 -> "II"
        3 -> "III"
        4 -> "IV"
        5 -> "V"
        6 -> "VI"
        7 -> "VII"
        8 -> "VIII"
        9 -> "IX"
        0 -> ""
      end

    check_next_digit(number, 1, [numeral])
  end

  defp from_decimal_to_roman(number, 1, numerals) do
    numeral =
      case elem(number, 1) do
        1 -> "X"
        2 -> "XX"
        3 -> "XXX"
        4 -> "XL"
        5 -> "L"
        6 -> "LX"
        7 -> "LXX"
        8 -> "LXXX"
        9 -> "XC"
        0 -> ""
      end

    check_next_digit(number, 2, [numeral | numerals])
  end

  defp from_decimal_to_roman(number, 2, numerals) do
    numeral =
      case elem(number, 2) do
        1 -> "C"
        2 -> "CC"
        3 -> "CCC"
        4 -> "CD"
        5 -> "D"
        6 -> "DC"
        7 -> "DCC"
        8 -> "DCCC"
        9 -> "CM"
        0 -> ""
      end

    check_next_digit(number, 3, [numeral | numerals])
  end

  defp from_decimal_to_roman(number, 3, numerals) do
    numeral =
      case elem(number, 3) do
        1 -> "M"
        2 -> "MM"
        3 -> "MMM"
      end

    from_decimal_to_roman([numeral | numerals])
  end

  defp check_next_digit(number, position, numeral) do
    if tuple_size(number) == position do
      from_decimal_to_roman(numeral)
    else
      from_decimal_to_roman(number, position, numeral)
    end
  end

  defp from_roman_to_decimal("", decimal), do: decimal

  defp from_roman_to_decimal("MMM" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 3000)

  defp from_roman_to_decimal("MM" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 2000)

  defp from_roman_to_decimal("M" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 1000)

  defp from_roman_to_decimal("CM" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 900)

  defp from_roman_to_decimal("DCCC" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 800)

  defp from_roman_to_decimal("DCC" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 700)

  defp from_roman_to_decimal("DC" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 600)

  defp from_roman_to_decimal("D" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 500)

  defp from_roman_to_decimal("CD" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 400)

  defp from_roman_to_decimal("CCC" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 300)

  defp from_roman_to_decimal("CC" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 200)

  defp from_roman_to_decimal("C" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 100)

  defp from_roman_to_decimal("XC" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 90)

  defp from_roman_to_decimal("LXXX" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 80)

  defp from_roman_to_decimal("LXX" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 70)

  defp from_roman_to_decimal("LX" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 60)

  defp from_roman_to_decimal("L" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 50)

  defp from_roman_to_decimal("XL" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 40)

  defp from_roman_to_decimal("XXX" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 30)

  defp from_roman_to_decimal("XX" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 20)

  defp from_roman_to_decimal("X" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 10)

  defp from_roman_to_decimal("IX" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 9)

  defp from_roman_to_decimal("VIII" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 8)

  defp from_roman_to_decimal("VII" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 7)

  defp from_roman_to_decimal("VI" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 6)

  defp from_roman_to_decimal("V" <> rest, decimal), do: from_roman_to_decimal(rest, decimal + 5)

  defp from_roman_to_decimal("IV" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 4)

  defp from_roman_to_decimal("III" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 3)

  defp from_roman_to_decimal("II" <> rest, decimal),
    do: from_roman_to_decimal(rest, decimal + 2)

  defp from_roman_to_decimal("I" <> _rest, decimal), do: decimal + 1
end
