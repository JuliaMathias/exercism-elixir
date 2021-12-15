defmodule Exercism.Numbers.AllYourBase do
  @moduledoc """
  Convert a number, represented as a sequence of digits in one base, to any other base.

  Implement general base conversion. Given a number in base a, represented as a sequence of digits, convert it to base b.

  ## Note
  - Try to implement the conversion yourself. Do not use something else to perform the conversion for you.

  ## About Positional Notation
  In positional notation, a number in base b can be understood as a linear combination of powers of b.

  The number 42, in base 10, means:

  (4 * 10^1) + (2 * 10^0)

  The number 101010, in base 2, means:

  (1 * 2^5) + (0 * 2^4) + (1 * 2^3) + (0 * 2^2) + (1 * 2^1) + (0 * 2^0)

  The number 1120, in base 3, means:

  (1 * 3^3) + (1 * 3^2) + (2 * 3^1) + (0 * 3^0)

  I think you got the idea!

  Yes. Those three numbers above are exactly the same. Congratulations!
  """

  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      output_base < 2 ->
        {:error, "output base must be >= 2"}

      input_base < 2 ->
        {:error, "input base must be >= 2"}

      not Enum.all?(digits, fn x -> x >= 0 and x < input_base end) ->
        {:error, "all digits must be >= 0 and < input base"}

      true ->
        calculate(digits, input_base, output_base)
    end
  end

  defp calculate(digits, input_base, output_base) do
    with number_base_10 <- to_base_10(digits, input_base),
         {:ok, validated_number} <- check_for_zeros(number_base_10) do
      {:ok, to_output_base(validated_number, output_base, [])}
    else
      _ -> {:ok, [0]}
    end
  end

  defp check_for_zeros(number_base_10),
    do: if(number_base_10 == 0, do: number_base_10, else: {:ok, number_base_10})

  defp to_base_10(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {number, index} -> {index, number * :math.pow(input_base, index)} end)
    |> Keyword.values()
    |> Enum.reduce(0, fn x, acc -> x + acc end)
    |> round()
  end

  defp to_output_base(0, _base, digits), do: Enum.reverse(digits)

  defp to_output_base(number, base, digits) do
    div = div(number, base)
    rem = rem(number, base)

    to_output_base(div, base, digits ++ [rem])
  end
end
