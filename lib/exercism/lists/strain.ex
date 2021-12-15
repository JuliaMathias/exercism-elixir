defmodule Exercism.Lists.Strain do
  @moduledoc """
  Implement the keep and discard operation on collections. Given a collection and a predicate on the collection's elements, keep returns a new collection containing those elements where the predicate is true, while discard returns a new collection containing those elements where the predicate is false.

  For example, given the collection of numbers:
  - 1, 2, 3, 4, 5

  And the predicate:
  - is the number even?

  Then your keep operation should produce:
  - 2, 4

  While your discard operation should produce:
  - 1, 3, 5

  Note that the union of keep and discard is all the elements.

  The functions may be called keep and discard, or they may need different names in order to not clash with existing functions or concepts in your language.

  ### Restrictions
  Keep your hands off that filter/reject/whatchamacallit functionality provided by your standard library! Solve this one yourself using other basic tools instead.
  """

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: do_keep(list, fun, [])

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: do_discard(list, fun, [])

  defp do_keep([], _fun, acc), do: acc

  defp do_keep([head | tail], fun, acc) do
    if fun.(head) do
      do_keep(tail, fun, acc ++ [head])
    else
      do_keep(tail, fun, acc)
    end
  end

  defp do_discard([], _fun, acc), do: acc

  defp do_discard([head | tail], fun, acc) do
    if fun.(head) do
      do_discard(tail, fun, acc)
    else
      do_discard(tail, fun, acc ++ [head])
    end
  end
end
