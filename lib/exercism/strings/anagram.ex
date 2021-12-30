defmodule Exercism.Strings.Anagram do
  @moduledoc """
  An anagram is a rearrangement of letters to form a new word. Given a word and a list of candidates, select the sublist of anagrams of the given word.

  Given "listen" and a list of candidates like "enlists" "google" "inlets" "banana" the program should return a list containing "inlets".
  """

  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    list_of_characters = split_and_sort(base)

    candidates
    |> filter_base_word(base, [])
    |> Enum.map(fn string -> {string, split_and_sort(string)} end)
    |> Enum.filter(fn x -> elem(x, 1) == list_of_characters end)
    |> Enum.map(fn {string, _list} -> string end)
  end

  defp split_and_sort(string) do
    string
    |> String.downcase()
    |> String.split("", trim: true)
    |> Enum.sort()
  end

  defp filter_base_word([], _base, list), do: Enum.reverse(list)

  defp filter_base_word([head | tail], base, list) do
    if String.upcase(head) == String.upcase(base) do
      filter_base_word(tail, base, list)
    else
      filter_base_word(tail, base, [head | list])
    end
  end
end
