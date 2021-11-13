defmodule Exercism.ErlangLibraries.CaptainsLog do
  @moduledoc """
  Mary is a big fan of the TV series Star Trek: The Next Generation. She often plays pen-and-paper role playing games, where she and her friends pretend to be the crew of the Starship Enterprise. Mary's character is Captain Picard, which means she has to keep the captain's log. She loves the creative part of the game, but doesn't like to generate random data on the spot.

  Help Mary by creating random generators for data commonly appearing in the captain's log.
  """
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  @doc """
  The Starship Enterprise encounters many planets in its travels. Planets in the Star Trek universe are split into categories based on their properties. For example, Earth is a class M planet. All possible planetary classes are: D, H, J, K, L, M, N, R, T, and Y.

  Implement the random_planet_class/0 function. It should return one of the planetary classes at random.

  ### Example

  iex> r = CaptainsLog.random_planet_class()
  r
  """
  @spec random_planet_class :: String.t()
  def random_planet_class, do: Enum.random(@planetary_classes)

  @doc """
  Enterprise (registry number NCC-1701) is not the only starship flying around! When it rendezvous with another starship, Mary needs to log the registry number of that starship.

  Registry numbers start with the prefix "NCC-" and then use a number from 1000 to 9999 (inclusive).

  Implement the random_ship_registry_number/0 function that returns a random starship registry number.

  ### Example

  iex> CaptainsLog.random_ship_registry_number()
  "NCC-1947"
  """
  @spec random_ship_registry_number :: String.t()
  def random_ship_registry_number, do: "NCC-#{Enum.random(1000..9999)}"

  @doc """
  What's the use of a log if it doesn't include dates?

  A stardate is a floating point number. The adventures of the Starship Enterprise from the first season of The Next Generation take place between the stardates 41000.0 and 42000.0. The "4" stands for the 24th century, the "1" for the first season.

  Implement the function random_stardate/0 that returns a floating point number between 41000.0 (inclusive) and 42000.0 (exclusive).

  ### Example

  iex> CaptainsLog.random_stardate()
  41458.15721310934
  """
  @spec random_stardate :: float
  def random_stardate, do: 41000.0 + :rand.uniform()

  @doc """


  ### Example

  In the captain's log, stardates are usually rounded to a single decimal place.

  Implement the format_stardate/1 function that will take a floating point number and return a string with the number rounded to a single decimal place.
  iex> CaptainsLog.format_stardate(41458.15721310934)
  "41458.2"
  """
  @spec format_stardate(float) :: String.t()
  def format_stardate(stardate) when is_float(stardate) do
    :io_lib.format("~.1f", [stardate]) |> List.to_string()
  end

  def format_stardate(_stardate),
    do: raise(ArgumentError, message: "the argument value is invalid")
end
