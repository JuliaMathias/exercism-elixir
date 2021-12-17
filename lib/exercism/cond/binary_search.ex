defmodule Exercism.Cond.BinarySearch do
  @moduledoc """
  Implement a binary search algorithm.

  Searching a sorted collection is a common task. A dictionary is a sorted list of word definitions. Given a word, one can find its definition. A telephone book is a sorted list of people's names, addresses, and telephone numbers. Knowing someone's name allows one to quickly find their telephone number and address.

  If the list to be searched contains more than a few items (a dozen, say) a binary search will require far fewer comparisons than a linear search, but it imposes the requirement that the list be sorted.

  In computer science, a binary search or half-interval search algorithm finds the position of a specified input value (the search "key") within an array sorted by key value.

  In each step, the algorithm compares the search key value with the key value of the middle element of the array.

  If the keys match, then a matching element has been found and its index, or position, is returned.

  Otherwise, if the search key is less than the middle element's key, then the algorithm repeats its action on the sub-array to the left of the middle element or, if the search key is greater, on the sub-array to the right.

  If the remaining array to be searched is empty, then the key cannot be found in the array and a special "not found" indication is returned.

  A binary search halves the number of items to check with each iteration, so locating an item (or determining its absence) takes logarithmic time. A binary search is a dichotomic divide and conquer search algorithm.
  """

  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  # def search(numbers, key) do
  #   numbers = Tuple.to_list(numbers)
  #   middle = numbers |> Enum.count() |> div(2)

  #   {first_half, second_half} = {[head1 | _tail1], [head2 | _tail2]} = Enum.split(numbers, middle)

  #   cond do
  #     key == head2 -> {:ok, head2}
  #     key == head1 -> {:ok, head1}
  #     key < head2 -> first_half |> List.to_tuple() |> search(key)
  #     true -> second_half |> List.to_tuple() |> search(key)
  #   end
  # end

  def search({}, _key), do: :not_found
  def search(numbers, key), do: bsearch(numbers, key, 0, tuple_size(numbers) - 1)

  @spec bsearch(tuple, integer, integer, integer) :: {:ok, integer} | :not_found
  defp bsearch(_numbers, _key, from, to) when from > to, do: :not_found

  defp bsearch(numbers, key, from, to) do
    index = from + div(to - from, 2)

    case elem(numbers, index) do
      ^key -> {:ok, index}
      result when result > key -> bsearch(numbers, key, from, index - 1)
      result when result < key -> bsearch(numbers, key, index + 1, to)
    end
  end
end
