defmodule Exercism.Guards.Say do
  @moduledoc """
  Given a number from 0 to 999,999,999,999, spell out that number in English.
  """

  @base_numbers %{
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine"
  }

  @teens %{
    1 => "eleven",
    2 => "twelve",
    3 => "thirteen",
    4 => "fourteen",
    5 => "fifteen",
    6 => "sixteen",
    7 => "seventeen",
    8 => "eighteen",
    9 => "nineteen"
  }

  @tens %{
    2 => "twenty",
    3 => "thirty",
    4 => "fourty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }


  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) do
    number
    |> Integer.digits()
    |> get_number()
  end

  defp get_number([head | _tail] = number) when length(number) == 1, do: {:ok, Map.get(@base_numbers, head)}
  defp get_number([head | tail] = number) when length(number) == 2 and head == 1, do: {:ok, Map.get(@teens, List.first(tail))}
  defp get_number([head | tail] = number) when length(number) == 2 and hd(tail) == 0, do: {:ok, Map.get(@tens, head) }
  defp get_number([head | tail] = number) when length(number) == 2, do: {:ok, "#{Map.get(@tens, head)}-#{Map.get(@base_numbers, List.first(tail))}" }
  defp get_number(_number), do: {:error, "number is out of range"}

end