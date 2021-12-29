defmodule Exercism.Tuples.Grains do
  @moduledoc """
  Calculate the number of grains of wheat on a chessboard given that the number on each square doubles.

  There once was a wise servant who saved the life of a prince. The king promised to pay whatever the servant could dream up. Knowing that the king loved chess, the servant told the king he would like to have grains of wheat. One grain on the first square of a chess board, with the number of grains doubling on each successive square.

  There are 64 squares on a chessboard (where square 1 has one grain, square 2 has two grains, and so on).

  Write code that shows:

  - how many grains were on a given square, and
  - the total number of grains on the chessboard

  ### For bonus points

  Did you get the tests passing and the code clean? If you want to, these are some additional things you could try:

  - Optimize for speed.
  - Optimize for readability.

  Then please share your thoughts in a comment on the submission. Did this experiment make the code better? Worse? Did you learn anything from it?
  """

  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(1) do
    {:ok, Integer.pow(2, 1) |> Kernel.-(1)}
  end

  def square(number) when number >= 2 and number <= 64 do
    {:ok, Integer.pow(2, number - 1)}
  end

  def square(_number), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    {:ok, Enum.reduce(1..64, fn x, acc -> elem(square(x), 1) + acc end)}
  end
end
