defmodule Exercism.KeywordLists.WineCellar do
  @moduledoc """
  You are the manager of a fancy restaurant that has a sizable wine cellar. A lot of your customers are demanding wine enthusiasts. Finding the right bottle of wine for a particular customer is not an easy task.

  As a tech-savvy restaurant owner, you decided to speed up the wine selection process by writing an app that will let guests filter your wines by their preferences.
  """

  @spec explain_colors :: [{:red, <<_::432>>} | {:rose, <<_::592>>} | {:white, <<_::248>>}, ...]
  @doc """
  On the welcome screen of your app, you want to display a short explanation of each wine color.

  Implement the WineCellar.explain_colors/0 function. It takes no arguments and returns a keyword list with wine colors as keys and explanations as values.

  Color	  Explanation
  :white	Fermented without skin contact.
  :red	  Fermented with skin contact using dark-colored grapes.
  :rose	  Fermented with some skin contact, but not enough to qualify as a red wine.

  ## Example
    iex> WineCellar.explain_colors()
    [white: "Fermented without skin contact.", red: "Fermented with skin contact using dark-colored grapes.", rose: "Fermented with some skin contact, but not enough to qualify as a red wine."]
  """
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  @spec filter(keyword, atom, [{:country, String.t()} | {:year, String.t()}]) :: list
  @doc """
  A bottle of wine is represented as a 3-tuple of grape variety, year, and country of origin. The wines are stored by wine color in a keyword list.

  [
  white: {"Chardonnay", 2015, "Italy"},
  white: {"Pinot grigio", 2017, "Germany"},
  red: {"Pinot noir", 2016, "France"},
  rose: {"Dornfelder", 2018, "Germany"}
  ]
  Implement the WineCellar.filter/3 function. It should take a keyword list of wines, a color atom and a keyword list of options, with a default value of []. The function should return a list of wines of a given color.

  Extend the WineCellar.filter/3 function. When given a :year option, the function should return a list of wines of a given color from a given year.

  Use the already-implemented WineCellar.filter_by_year/2 function. It takes a list of wines and a year as arguments and returns a list of wines from a given year.

  Extend the WineCellar.filter/3 function. When given a :country option, the function should return a list of wines of a given color from a given country.

  Use the already-implemented WineCellar.filter_by_country/2 function. It takes a list of wines and a country as arguments and returns a list of wines from a given country.

  Make sure that the function works when given both the :year and the :country option, in any order.

  ## Examples
  iex> WineCellar.filter([white: {"Chardonnay", 2015, "Italy"}, white: {"Pinot grigio", 2017, "Germany"}, red: {"Pinot noir", 2016, "France"}, rose: {"Dornfelder", 2018, "Germany"}],:white)
  [{"Chardonnay", 2015, "Italy"},{"Pinot grigio", 2017, "Germany"}]

  iex> WineCellar.filter([white: {"Chardonnay", 2015, "Italy"}, white: {"Pinot grigio", 2017, "Germany"}, red: {"Pinot noir", 2016, "France"}, rose: {"Dornfelder", 2018, "Germany"}],:white, year: 2015)
  [{"Chardonnay", 2015, "Italy"}]

  iex> WineCellar.filter([white: {"Chardonnay", 2015, "Italy"}, white: {"Pinot grigio", 2017, "Germany"}, red: {"Pinot noir", 2016, "France"}, rose: {"Dornfelder", 2018, "Germany"}],:white, year: 2015, country: "Germany")
  []

  iex> WineCellar.filter([white: {"Chardonnay", 2015, "Italy"}, white: {"Pinot grigio", 2017, "Germany"}, red: {"Pinot noir", 2016, "France"}, rose: {"Dornfelder", 2018, "Germany"}],:white, country: "Germany", year: 2015)
  []
  """

  def filter(cellar, color, opts \\ []) do
    Keyword.get_values(cellar, color)
    |> maybe_filter_by_year(opts)
    |> maybe_filter_by_country(opts)
  end

  defp maybe_filter_by_year(color_list, opts) do
    if Keyword.has_key?(opts, :year) do
      year = Keyword.get_values(opts, :year) |> Enum.at(0)
      filter_by_year(color_list, year)
    else
      color_list
    end
  end

  defp maybe_filter_by_country(color_list, opts) do
    if Keyword.has_key?(opts, :country) do
      country = Keyword.get_values(opts, :country) |> Enum.at(0)
      filter_by_country(color_list, country)
    else
      color_list
    end
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
