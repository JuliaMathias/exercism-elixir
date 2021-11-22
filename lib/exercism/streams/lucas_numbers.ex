defmodule Exercism.Streams.LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...

  You are a huge fan of the Numberphile Youtube channel and you just saw a cool video about the Lucas Number Sequence. You want to create this sequence using Elixir.

  While designing your function, you want to make use of lazy evaluation, so that you can generate as many numbers as you want, but only if you need to -- So you decide to use a stream:
  """
  @spec generate(integer) :: list
  def generate(count) when not is_integer(count) or count < 1,
    do: raise(ArgumentError, message: "count must be specified as an integer >= 1")

  def generate(count) do
    case count do
      1 ->
        [2]

      2 ->
        [2, 1]

      _ ->
        Stream.iterate({2, 1}, fn {x, y} -> {y, x + y} end)
        |> Stream.map(&elem(&1, 0))
        |> Enum.take(count)
    end
  end
end
