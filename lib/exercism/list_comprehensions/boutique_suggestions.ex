defmodule Exercism.ListComprehensions.BoutiqueSuggestions do
  @moduledoc """
  Your work at the online fashion boutique store continues. You come up with the idea for a website feature where an outfit is suggested to the user. While you want to give lots of suggestions, you don't want to give bad suggestions, so you decide to use a list comprehension since you can easily generate outfit combinations, then filter them by some criteria.

  Clothing items are stored as a map:

  %{
  item_name: "Descriptive Name",
  price: 99.00,
  base_color: "red"
  }
  """

  @spec get_combinations(list, list, keyword) :: list
  @doc """
  Implement get_combinations/3 to take a list of tops, a list of bottoms, and keyword list of options. For now, set options to default to an empty keyword list. The function should return the cartesian product of the lists.

  ### Example

  iex> tops = [%{item_name: "Dress shirt"}, %{item_name: "Casual shirt"}]
  iex> bottoms = [%{item_name: "Jeans"}, %{item_name: "Dress trousers"}]
  iex> BoutiqueSuggestions.get_combinations(tops, bottoms)
  [{%{item_name: "Dress shirt"}, %{item_name: "Jeans"}}, {%{item_name: "Dress shirt"}, %{item_name: "Dress trousers"}}, {%{item_name: "Casual shirt"}, %{item_name: "Jeans"}}, {%{item_name: "Casual shirt"}, %{item_name: "Dress trousers"}}]


  Each piece of clothing has a :base_color field, use this field to filter out all combinations where the top and the bottom have the same base color.

  ### Example

  iex> tops = [%{item_name: "Dress shirt", base_color: "blue"}, %{item_name: "Casual shirt", base_color: "black"}]
  iex> bottoms = [%{item_name: "Jeans", base_color: "blue"}, %{item_name: "Dress trousers", base_color: "black"}]
  iex> BoutiqueSuggestions.get_combinations(tops, bottoms)
  [{%{item_name: "Dress shirt"}, %{item_name: "Dress trousers"}}, {%{item_name: "Casual shirt"}, %{item_name: "Jeans"}}]

  Each piece of clothing has a :price field associated with it. While you want to give lots of suggestions, you want to be able to provide users an opportunity to select a price within their budget. From the keyword list of options, use :maximum_price to filter out combinations where the price of the top and bottom exceed the maximum price.

  If no maximum_price is specified, the default should be 100.00

  ### Example

  iex> tops = [%{item_name: "Dress shirt", base_color: "blue", price: 35}, %{item_name: "Casual shirt", base_color: "black", price: 20}]
  iex> bottoms = [%{item_name: "Jeans", base_color: "blue", price: 30}, %{item_name: "Dress trousers", base_color: "black", price: 75}]
  iex> BoutiqueSuggestions.get_combinations(tops, bottoms, maximum_price: 50)
  [{%{item_name: "Casual shirt"}, %{item_name: "Jeans"}}]


  """
  def get_combinations(tops, bottoms, options \\ []) do
    cond do
      Map.has_key?(Enum.fetch!(tops, 0), :price) ->
        maximum_price = Keyword.get(options, :maximum_price, 100)

        for top <- tops,
            bottom <- bottoms,
            top.base_color != bottom.base_color,
            top.price + bottom.price <= maximum_price do
          {top, bottom}
        end

      Map.has_key?(Enum.fetch!(tops, 0), :base_color) ->
        for x <- tops, y <- bottoms, x.base_color != y.base_color do
          {Map.take(x, [:item_name]), Map.take(y, [:item_name])}
        end

      true ->
        for x <- tops,
            y <- bottoms do
          {x, y}
        end
    end
  end
end
