defmodule Exercism.AccessBehaviour.BasketballWebsite do
  @moduledoc """
  You are working with a web development team to maintain a website for a local basketball team. The web development team is less familiar with Elixir and is asking for a function to be able to extract data from a series of nested maps to facilitate rapid development.

  """

  @spec extract_from_path(any, binary) :: any
  @doc """
  Implement the extract_from_path/2 function to take two arguments:

  - data: a nested map structure with data about the basketball team.
  - path: a string consisting of period-delimited keys to obtain the value associated with the last key.

  If the value or the key does not exist at any point in the path, nil should be returned

  ## Examples
    iex> data = %{"team_mascot" => %{"animal" => "bear","actor" => %{"first_name" => "Noel"}}}
    iex> BasketballWebsite.extract_from_path(data, "team_mascot.animal")
    "bear"
    iex> BasketballWebsite.extract_from_path(data, "team_mascot.colors")
    nil
    iex> BasketballWebsite.extract_from_path(data, "team_mascot.actor.first_name")
    "Noel"
  """
  def extract_from_path(data, path), do: String.split(path, ".") |> do_extract_from_path(data)

  @spec get_in_path(any, binary) :: any
  @doc """
  Your coworker reviewing your code tells you about a Kernel module functions which does something very similar to your implementation.

  Implement get_in_path/2 to use this Kernel module function.

  The arguments expected are the same as part 1.

  ## Examples
    iex> data = %{"team_mascot" => %{"animal" => "bear","actor" => %{"first_name" => "Noel"}}}
    iex> BasketballWebsite.get_in_path(data, "team_mascot.actor.first_name")
    "Noel"
  """
  def get_in_path(data, path) do
    opts = String.split(path, ".")
    Kernel.get_in(data, opts)
  end

  defp do_extract_from_path([], data), do: data

  defp do_extract_from_path(_, nil), do: nil

  defp do_extract_from_path([path | next], data), do: do_extract_from_path(next, data[path])
end
