defmodule Exercism.Regex.DateParser do
  @moduledoc """
  You have been tasked to write a service which ingests events. Each event has a date associated with it, but you notice that 3 different formats are being submitted to your service's endpoint:

  "01/01/1970"
  "January 1, 1970"
  "Thursday, January 1, 1970"
  You can see there are some similarities between each of them, and decide to write some composable regular expression patterns.
  """

  # Implement day/0, month/0, and year/0 to return a string pattern which, when compiled, would match the numeric components in "01/01/1970" (dd/mm/yyyy). The day and month may appear as 1 or 01 (left padded with zeroes).

  @doc """
  Parses day from a date.

  ## Examples
    iex> "1" =~ DateParser.day() |> Regex.compile!()
    true
    iex> "02" =~ DateParser.day() |> Regex.compile!()
    true
    iex> "32" =~ DateParser.day() |> Regex.compile!()
    false
    iex> "45" =~ DateParser.day() |> Regex.compile!()
    false
    iex> "31" =~ DateParser.day() |> Regex.compile!()
    true
  """
  def day(), do: "(?<day>0[1-9]|1[0-9]|2[0-9]|3[0-1]|^[1-9]$)"

  @doc """
  Parses month from a date.

  ## Example
    iex> "31" =~ DateParser.month() |> Regex.compile!()
    false
    iex> "1" =~ DateParser.month() |> Regex.compile!()
    true
    iex> "12" =~ DateParser.month() |> Regex.compile!()
    true
  """
  def month(), do: "(?<month>0[1-9]|1[0-9]|^[1-9]$)"

  @doc """
  Parses year from a date.

  ## Example
    iex> "1994" =~ DateParser.year() |> Regex.compile!()
    true
    iex> "994" =~ DateParser.year() |> Regex.compile!()
    false
  """
  def year(), do: "(?<year>\\d{4})"

  def day_names() do
    # Please implement the day_names/0 function
  end

  def month_names() do
    # Please implement the month_names/0 function
  end

  def capture_day() do
    # Please implement the capture_day/0 function
  end

  def capture_month() do
    # Please implement the capture_month/0 function
  end

  def capture_year() do
    # Please implement the capture_year/0 function
  end

  def capture_day_name() do
    # Please implement the capture_day_name/0 function
  end

  def capture_month_name() do
    # Please implement the capture_month_name/0 function
  end

  def capture_numeric_date() do
    # Please implement the capture_numeric_date/0 function
  end

  def capture_month_name_date() do
    # Please implement the capture_month_name_date/0 function
  end

  def capture_day_month_name_date() do
    # Please implement the capture_day_month_name_date/0 function
  end

  def match_numeric_date() do
    # Please implement the match_numeric_date/0 function
  end

  def match_month_name_date() do
    # Please implement the match_month_name_day/0 function
  end

  def match_day_month_name_date() do
    # Please implement the match_day_month_name_date/0 function
  end
end
