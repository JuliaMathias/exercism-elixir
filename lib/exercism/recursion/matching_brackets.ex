defmodule Exercism.Recursion.MatchingBrackets do
  @moduledoc """
  Given a string containing brackets `[]`, braces `{}`, parentheses `()`, or any combination thereof, verify that any and all pairs are matched and nested correctly.
  """

  @start ["[", "{", "("]
  @ending ["]", "}", ")"]
  @matches %{"]" => "[", "}" => "{", ")" => "("}

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly

  "([{}({}[])])"
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.split("", trim: true)
    |> traverse([])
  end

  # the idea here is to basically grab the first character of the string and then check:
  #  - is it a start? store it in start
  #  - is it an end? then we check
  #     - if the start is empty we fail it
  #     - does it match the last element of the start array? if not we fail it
  #     - if it matches, we pop the last element of the start array
  #   - is it another type of character? ignore it
  # then when the string is empty we check if the start and end arrays are empty

  defp traverse([], []), do: true
  defp traverse([], _start), do: false
  defp traverse([h | t], start) when h in @start, do: traverse(t, start ++ [h])
  defp traverse([h | _t] = string, start) when h in @ending, do: check_end(string, start)
  defp traverse([_h | t], start), do: traverse(t, start)

  defp check_end([h | t], start) do
    cond do
      start == [] -> false
      Map.get(@matches, h) == List.last(start) -> traverse(t, List.delete_at(start, -1))
      true -> false
    end
  end
end
