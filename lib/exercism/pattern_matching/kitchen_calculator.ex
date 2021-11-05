defmodule Exercism.PatternMatching.KitchenCalculator do
  @moduledoc """
  While preparing to bake cookies for your friends, you have found that you have to convert some of the measurements used in the recipe. Being only familiar with the metric system, you need to come up with a way to convert common US baking measurements to milliliters (mL) for your own ease.

  Use this conversion chart for your solution:

  Unit to convert	volume	in milliliters (mL)
  mL               1	     1
  US cup	         1	     240
  US fluid ounce	 1	     30
  US teaspoon	     1	     5
  US tablespoon	   1	     15

  Being a talented programmer in training, you decide to use milliliters as a transition unit to facilitate the conversion from any unit listed to any other (even itself).
  """

  @spec get_volume({atom, number}) :: float
  @doc """
  Implement the KitchenCalculator.get_volume/1 function. Given a volume-pair tuple, it should return just the numeric component.

  ## Example
    iex> KitchenCalculator.get_volume({:cup, 2.0})
    2.0
  """
  def get_volume({_unit, volume}), do: volume

  @spec to_milliliter({atom, number}) :: {:milliliter, number}
  @doc """
  Implement the KitchenCalculator.to_milliliter/1 function. Given a volume-pair tuple, it should convert the volume to milliliters using the conversion chart.

  Use multiple function clauses and pattern matching to create the functions for each unit. The atoms used to denote each unit are: :cup, :fluid_ounce, :teaspoon, :tablespoon, :milliliter. Return the result of the conversion wrapped in a tuple.

  ### Example
  iex> KitchenCalculator.to_milliliter({:cup, 2.5})
  {:milliliter, 600.0}
  """
  def to_milliliter({:cup, volume}), do: {:milliliter, volume * 240.0}
  def to_milliliter({:fluid_ounce, volume}), do: {:milliliter, volume * 30.0}
  def to_milliliter({:teaspoon, volume}), do: {:milliliter, volume * 5.0}
  def to_milliliter({:tablespoon, volume}), do: {:milliliter, volume * 15.0}
  def to_milliliter({:milliliter, volume}), do: {:milliliter, volume}

  @spec from_milliliter({atom, number}, atom) :: {atom, float}
  @doc """
  Implement the KitchenCalculator.from_milliliter/2 function. Given a volume-pair tuple and the desired unit, it should convert the volume to the desired unit using the conversion chart.

  Use multiple function clauses and pattern matching to create the functions for each unit. The atoms used to denote each unit are: :cup, :fluid_ounce, :teaspoon, :tablespoon, :milliliter

  ### Example
  iex> KitchenCalculator.from_milliliter({:milliliter, 1320.0}, :cup)
  {:cup, 5.5}
  """
  def from_milliliter({:milliliter, volume}, :cup), do: {:cup, volume / 240.0}
  def from_milliliter({:milliliter, volume}, :fluid_ounce), do: {:fluid_ounce, volume / 30.0}
  def from_milliliter({:milliliter, volume}, :teaspoon), do: {:teaspoon, volume / 5.0}
  def from_milliliter({:milliliter, volume}, :tablespoon), do: {:tablespoon, volume / 15.0}
  def from_milliliter({:milliliter, volume}, :milliliter), do: {:milliliter, volume}

  @spec convert({atom, number}, atom) :: {atom, float}
  @doc """
  Implement the KitchenCalculator.convert/2 function. Given a volume-pair tuple and the desired unit, it should convert the given volume to the desired unit.

  ### Example
  iex> KitchenCalculator.convert({:teaspoon, 9.0}, :tablespoon)
  {:tablespoon, 3.0}
  """
  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end

# Questions for mentoring:

# The question I have is not so much about the code but about the concept explanation. On the tuples section it says: "Tuples are often used in Elixir for memory read-intensive operations, since read-access of an element is a constant-time operation." What's a constant-time operation? Also feel free to suggest any other improvement sto the code.
