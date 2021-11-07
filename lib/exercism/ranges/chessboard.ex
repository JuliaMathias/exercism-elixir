defmodule Exercism.Ranges.Chessboard do
  @moduledoc """
  As a chess enthusiast, you would like to write your own version of the game. Yes, there maybe plenty of implementations of chess available online already, but yours will be unique!

  But before you can let your imagination run wild, you need to take care of the basics. Let's start by generating the board.

  Each square of the chessboard is identified by a letter-number pair. The vertical columns of squares, called files, are labeled A through H. The horizontal rows of squares, called ranks, are numbered 1 to 8.
  """

  @spec rank_range :: Range.t()
  @doc """
  Implement the rank_range/0 function. It should return a range of integers, from 1 to 8.

  ### Example
  Chessboard.rank_range()
  iex> 1..8

  """
  def rank_range, do: 1..8

  @spec file_range :: Range.t()
  @doc """
  Implement the file_range/0 function. It should return a range of integers, from the code point of the uppercase letter A, to the code point of the uppercase letter H.

  ### Example

  iex> Chessboard.file_range()
  65..72
  """
  def file_range, do: 65..72

  @doc """
  Implement the ranks/0 function. It should return a list of integers, from 1 to 8. Do not write the list by hand, generate it from the range returned by the rank_range/0 function

  ### Example

  iex> Chessboard.ranks()
  [1, 2, 3, 4, 5, 6, 7, 8]
  """
  def ranks, do: rank_range() |> Enum.to_list()

  @spec files :: list
  @doc """
  Implement the files/0 function. It should return a list of letters (strings), from "A" to "H". Do not write the list by hand, generate it from the range returned by the file_range/0 function.

  ### Example

  iex> Chessboard.files()
  ["A", "B", "C", "D", "E", "F", "G", "H"]
  """
  def files do
    files = file_range() |> Enum.to_list()
    Enum.map(files, fn x -> <<x::utf8>> end)
  end
end
