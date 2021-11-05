defmodule Exercism.Lists.LanguageList do
  @spec new :: []
  def new, do: []

  @spec add(list, binary) :: nonempty_maybe_improper_list
  def add(list, language), do: [language | list]

  @spec remove(nonempty_maybe_improper_list) :: list
  def remove(list) do
    [_head | tail] = list

    tail
  end

  @spec first(nonempty_maybe_improper_list) :: list
  def first(list) do
    [head | _tail] = list

    head
  end

  @spec count(list) :: non_neg_integer
  def count(list), do: Enum.count(list)

  @spec exciting_list?(list) :: boolean
  def exciting_list?(list), do: Enum.member?(list, "Elixir")
end
