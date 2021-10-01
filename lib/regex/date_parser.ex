defmodule Exercism.Regex.DateParser do
  @moduledoc """
  You have been tasked to write a service which ingests events. Each event has a date associated with it, but you notice that 3 different formats are being submitted to your service's endpoint:

  "01/01/1970"
  "January 1, 1970"
  "Thursday, January 1, 1970"
  You can see there are some similarities between each of them, and decide to write some composable regular expression patterns.
  """

  # Implement day/0, month/0, and year/0 to return a string pattern which, when compiled, would match the numeric components in "01/01/1970" (dd/mm/yyyy). The day and month may appear as 1 or 01 (left padded with zeroes).

  @spec day :: binary
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

  @spec month :: binary
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

  @spec year :: binary
  @doc """
  Parses year from a date.

  ## Example
    iex> "1994" =~ DateParser.year() |> Regex.compile!()
    true
    iex> "994" =~ DateParser.year() |> Regex.compile!()
    false
  """
  def year(), do: "(?<year>\\d{4})"

  @spec day_names :: binary
  @doc """
  Implement day_names/0 to return a string pattern which, when compiled, would match the named day of the week.

  ## Example
    iex> "Tuesday" =~ DateParser.day_names() |> Regex.compile!()
    true
    iex> "Abracadabra" =~ DateParser.day_names() |> Regex.compile!()
    false

  """
  def day_names(), do: "(?<day_name>Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday)"

  @spec month_names :: binary
  @doc """
  Implement month_names/0 to return a string pattern which, when compiled, would match the named month of the year.

  ## Example
    iex> "March" =~ DateParser.month_names() |> Regex.compile!()
    true
    iex> "Abracadabra" =~ DateParser.month_names() |> Regex.compile!()
    false
  """
  def month_names() do
    "(?<month_name>January|February|March|April|May|June|July|August|September|October|November|December)"
  end

  @spec capture_day :: binary
  @doc """
  Implement capture_day/0 to return a string pattern which captures the day component to the names.

  ## Example
    iex> DateParser.capture_day() |> Regex.compile!() |> Regex.named_captures("01")
    %{"day" => "01"}
  """
  def capture_day(), do: day()

  @spec capture_month :: binary
  @doc """
  Implement capture_month/0 to return a string pattern which captures the month component to the names.

  ## Example
    iex> DateParser.capture_month() |> Regex.compile!() |> Regex.named_captures("01")
    %{"month" => "01"}
  """
  def capture_month(), do: month()

  @spec capture_year :: binary
  @doc """
  Implement capture_year/0 to return a string pattern which captures the year component to the names.

  ## Example
    iex> DateParser.capture_year() |> Regex.compile!() |> Regex.named_captures("2001")
    %{"year" => "2001"}
  """
  def capture_year(), do: year()

  @spec capture_day_name :: binary
  @doc """
  Implement capture_day_name/0 to return a string pattern which captures the day_name component to the names.

  ## Example
    iex> DateParser.capture_day_name() |> Regex.compile!() |> Regex.named_captures("Monday")
    %{"day_name" => "Monday"}
  """
  def capture_day_name(), do: day_names()

  @spec capture_month_name :: binary
  @doc """
  Implement capture_month_name/0 to return a string pattern which captures the month_name component to the names.

  ## Example
    iex> DateParser.capture_month_name() |> Regex.compile!() |> Regex.named_captures("December")
    %{"month_name" => "December"}
  """
  def capture_month_name(), do: month_names()

  @spec capture_numeric_date :: binary
  def capture_numeric_date(), do: day() <> "/" <> month() <> "/" <> year()

  @spec capture_month_name_date :: binary
  def capture_month_name_date() do
    month_names() <> " " <> day() <> ", " <> year()
  end

  @spec capture_day_month_name_date :: binary
  def capture_day_month_name_date(), do: day_names() <> ", " <> capture_month_name_date()

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
