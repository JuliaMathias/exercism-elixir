defmodule Exercism.Pipe.Acronym do
  @moduledoc """
  Convert a phrase to its acronym.

  Techies love their TLA (Three Letter Acronyms)!

  Help generate some jargon by writing a program that converts a long name like Portable Network Graphics to its acronym (PNG).
  """

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace("_", " ")
    |> String.replace("-", " ")
    |> String.split()
    |> Enum.map(fn x -> String.first(x) end)
    |> Enum.join()
    |> String.upcase()
  end
end
