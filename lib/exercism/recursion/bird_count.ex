defmodule Exercism.Recursion.BirdCount do
  @moduledoc """
  You're an avid bird watcher that keeps track of how many birds have visited your garden on any given day.

  You decided to bring your bird watching to a new level and implement a few tools that will help you track and process the data.

  You have chosen to store the data as a list of integers. The first number in the list is the number of birds that visited your garden today, the second yesterday, and so on.
  """

  @spec today(list) :: integer | nil
  @doc """
  Implement the BirdCount.today/1 function. It should take a list of daily bird counts and return today's count. If the list is empty, it should return nil.

  ## Example
    iex> BirdCount.today([2, 5, 1])
    2
  """
  def today([]), do: nil

  def today([head | _tail]), do: head

  @spec increment_day_count(maybe_improper_list) :: nonempty_maybe_improper_list
  @doc """
  Implement the BirdCount.increment_day_count/1 function. It should take a list of daily bird counts and increment the today's count by 1. If the list is empty, return [1].

  ## Example
    iex> BirdCount.increment_day_count([4, 0, 2])
    [5, 0, 2]
  """
  def increment_day_count([]), do: [1]

  def increment_day_count([head | tail]), do: [head + 1 | tail]

  @spec has_day_without_birds?(list) :: boolean
  @doc """
  Implement the BirdCount.has_day_without_birds?/1 function. It should take a list of daily bird counts. It should return true if there was at least one day when no birds visited the garden, and false otherwise.

  ## Examples
    iex> BirdCount.has_day_without_birds?([2, 0, 4])
    true
    iex> BirdCount.has_day_without_birds?([3, 8, 1, 5])
    false
  """
  def has_day_without_birds?([]), do: false

  def has_day_without_birds?([head | tail]) do
    case head do
      0 -> true
      _ -> has_day_without_birds?(tail)
    end
  end

  @spec total(list) :: integer
  @doc """
  Implement the BirdCount.total/1 function. It should take a list of daily bird counts and return the total number that visited your garden since you started collecting the data.

  ## Example
    iex> BirdCount.total([4, 0, 9, 0, 5])
    18
  """
  def total([]), do: 0

  def total([head | tail]), do: do_reduce(tail, &(&1 + &2), head)

  @doc """
  Some days are busier that others. A busy day is one where five or more birds have visited your garden.

  Implement the BirdCount.busy_days/1 function. It should take a list of daily bird counts and return the number of busy days.

  ## Example
    iex> BirdCount.busy_days([4, 5, 0, 0, 6])
    2
  """
  def busy_days(list), do: filter_numbers(list, &(&1 >= 5), []) |> Enum.count()

  defp do_reduce([], _fun, acc) do
    acc
  end

  defp do_reduce([head | tail], fun, acc) do
    result = fun.(head, acc)
    do_reduce(tail, fun, result)
  end

  defp filter_numbers([], _fun, acc) do
    Enum.reverse(acc)
  end

  defp filter_numbers([head | tail], fun, acc) do
    case fun.(head) do
      true ->
        filter_numbers(tail, fun, [head | acc])

      false ->
        filter_numbers(tail, fun, acc)
    end
  end
end
