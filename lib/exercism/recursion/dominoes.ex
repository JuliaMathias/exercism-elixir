defmodule Exercism.Recursion.Dominoes do
  @type domino :: {1..6, 1..6}
  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([head | tail]) do
    make_chains([head], tail)
  end
  def make_chains(current_chain, []) do
    {first1, _first2} = List.first(current_chain)
    {_last1, last2} = List.last(current_chain)
    first1 == last2
  end
  def make_chains([{half1, _half2} | _tail] = current_chain, remaining_dominoes) do
    sorted_remaining = Enum.map(remaining_dominoes, fn {x, y} ->
      if x == half1 do
        {y,x}
      else
        {x,y}
      end
    end)
    case Enum.filter(sorted_remaining, fn {_value1, value2} -> value2 == half1 end) do
      [] -> false
      dominoes_to_try -> Enum.any?(dominoes_to_try, fn domino ->
        remaining_dominoes = List.delete(sorted_remaining, domino)
        current_chain = [domino | current_chain]
        make_chains(current_chain, remaining_dominoes)
      end)
    end
  end
end