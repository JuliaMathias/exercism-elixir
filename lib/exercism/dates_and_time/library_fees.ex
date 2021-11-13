defmodule Exerscism.DatesAndTime.LibraryFees do
  @moduledoc """
  Your librarian friend has asked you to extend her library software to automatically calculate late fees. Her current system stores the exact date and time of a book checkout as an ISO8601 datetime string. She runs a local library in a small town in Ghana, which uses the GMT timezone (UTC +0), doesn't use daylight saving time, and doesn't need to worry about other timezones.
  """

  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  @doc """
  Implement the LibraryFees.datetime_from_string/1 function. It should take an ISO8601 datetime string as an argument, and return a NaiveDateTime struct.

  ## Example
    iex> LibraryFees.datetime_from_string("2021-01-01T13:30:45Z")
    ~N[2021-01-01 13:30:45]
  """
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  @spec before_noon?(%{
          :calendar => any,
          :day => any,
          :hour => any,
          :microsecond => any,
          :minute => any,
          :month => any,
          :second => any,
          :year => any,
          optional(any) => any
        }) :: boolean
  @doc """
  If a book was checked out before noon, the reader has 28 days to return it. If it was checked out at or after noon, it's 29 days.

  Implement the LibraryFees.before_noon?/1 function. It should take a NaiveDateTime struct and return a boolean.

  ## Examples
    iex> LibraryFees.before_noon?(~N[2021-01-12 08:23:03])
    true
    iex> LibraryFees.before_noon?(~N[2021-01-12 12:00:00])
    false
    iex> LibraryFees.before_noon?(~N[2021-01-12 18:23:03])
    false
  """
  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(~T[12:00:00])
    |> case do
      :lt -> true
      :gt -> false
      :eq -> false
    end
  end

  @spec return_date(%{
          :calendar => any,
          :day => any,
          :hour => any,
          :microsecond => any,
          :minute => any,
          :month => any,
          :second => any,
          :year => any,
          optional(any) => any
        }) :: Date.t()
  @doc """
  Based on the checkout datetime, calculate the return date.

  Implement the LibraryFees.return_date/1 function. It should take a NaiveDateTime struct and return a Date struct, either 28 or 29 days later.
  ## Example
    iex> LibraryFees.return_date(~N[2020-11-28 15:55:33])
    ~D[2020-12-27]
  """
  def return_date(checkout_datetime) do
    case before_noon?(checkout_datetime) do
      true -> checkout_datetime |> NaiveDateTime.to_date() |> Date.add(28)
      false -> checkout_datetime |> NaiveDateTime.to_date() |> Date.add(29)
    end
  end

  @doc """
  The library has a flat rate for late returns. To be able to calculate the fee, we need to know how many days after the return date the book was actually returned.

  Implement the LibraryFees.days_late/2 function. It should take a Date struct - the planned return datetime, and a NaiveDateTime struct - the actual return datetime.

  If the actual return date is on an earlier or the same day as the planned return datetime, the function should return 0. Otherwise, the function should return the difference between those two dates in days.

  The library tracks both the date and time of the actual return of the book for statistical purposes, but doesn't use the time when calculating late fees.

  ## Example
    iex> LibraryFees.days_late(~D[2020-12-27], ~N[2021-01-03 09:23:36])
    7
  """
  def days_late(planned_return_date, actual_return_datetime) do
    days_late =
      actual_return_datetime
      |> NaiveDateTime.to_date()
      |> Date.diff(planned_return_date)

    if days_late <= 0, do: 0, else: days_late
  end

  @doc """
  The library has a special offer for returning books on Mondays.

  Implement the LibraryFees.monday?/1 function. It should take a NaiveDateTime struct and return a boolean.

  ## Example
    iex> LibraryFees.monday?(~N[2021-01-03 13:30:45Z])
    false
  """
  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> case do
      1 -> true
      _ -> false
    end
  end

  @doc """
  Implement the LibraryFees.calculate_late_fee/3 function. It should take three arguments - two ISO8601 datetime strings, checkout datetime and actual return datetime, and the late fee for one day. It should return the total late fee according to how late the actual return of the book was.

  Include the special Monday offer. If you return the book on Monday, your late fee is 50% off, rounded down.

  ## Examples

    iex> LibraryFees.calculate_late_fee("2020-11-28T15:55:33Z", "2021-01-03T13:30:45Z", 100)
    700

    iex> LibraryFees.calculate_late_fee("2020-11-28T15:55:33Z", "2021-01-04T09:02:11Z", 100)
    400
  """

  def calculate_late_fee(checkout, return, rate) do
    planned_return = checkout |> datetime_from_string() |> return_date()

    return = datetime_from_string(return)

    days_late = days_late(planned_return, return)

    fee = rate * days_late

    if monday?(return), do: div(fee, 2), else: fee
  end
end
