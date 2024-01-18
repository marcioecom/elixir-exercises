defmodule LibraryFees do
  @monday 1
  @noon ~T[12:00:00]
  @monday_late_fee 0.5

  @doc """
  Takes an ISO8601 datetime string as an argument, and returns a NaiveDateTime struct.

  ## Examples:

      iex> LibraryFees.datetime_from_string("2021-01-01T13:30:45Z")
      ~N[2021-01-01 13:30:45]

  """
  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  @doc """
  Takes a NaiveDateTime struct and returns whether the a book was checked out before noon.

  ## Examples:

      iex> LibraryFees.before_noon?(~N[2021-01-12 08:23:03])
      true

  """
  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(@noon) == :lt
  end

  @doc """
  Takes a NaiveDateTime struct and returns a Date struct, either 28 or 29 days later.

  ## Examples:

      iex> LibraryFees.return_date(~N[2020-11-28 15:55:33])
      ~D[2020-12-27]

  """
  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      Date.add(checkout_datetime, 28)
    else
      Date.add(checkout_datetime, 29)
    end
  end

  @doc """
  Calculates how many days after the return date the book was actually returned.

  ## Examples:

      iex> LibraryFees.days_late(~D[2020-12-27], ~N[2021-01-03 09:23:36])
      7

  """
  @spec days_late(Date.t(), NaiveDateTime.t()) :: non_neg_integer()
  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  @doc """
  Takes a NaiveDateTime struct and returns a boolean.

  ## Examples:

      iex> LibraryFees.monday?(~N[2021-01-03 13:30:45Z])
      false

  """
  @spec monday?(NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == @monday
  end

  @doc """
  Returns the total late fee according to how late the actual return of the book was.
  Includes a special 50% off Monday offer.

  ## Examples:

      iex> LibraryFees.calculate_late_fee("2020-11-28T15:55:33Z", "2021-01-03T13:30:45Z", 100)
      700

      iex> LibraryFees.calculate_late_fee("2020-11-28T15:55:33Z", "2021-01-04T09:02:11Z", 100)
      400

  """
  @spec calculate_late_fee(String.t(), String.t(), non_neg_integer()) :: non_neg_integer()
  def calculate_late_fee(checkout, return, rate) do
    planned_return_date =
      checkout
      |> datetime_from_string
      |> return_date

    actual_return_datetime =
      return
      |> datetime_from_string

    planned_return_date
    |> days_late(actual_return_datetime)
    |> apply_fee(actual_return_datetime, rate)
  end

  @doc """
  Takes the number of days late and the actual return datetime and returns the late fee.
  If the book was returned on a Monday, the late fee is 50% off.

  ## Examples:

      iex> LibraryFees.apply_fee(7, ~N[2021-01-03 13:30:45Z], 100)
      700

      iex> LibraryFees.apply_fee(7, ~N[2021-01-04 09:02:11Z], 100)
      400
  """
  @spec apply_fee(non_neg_integer(), NaiveDateTime.t(), non_neg_integer()) :: non_neg_integer()
  defp apply_fee(days_late, actual_return_datetime, rate) do
    if monday?(actual_return_datetime) do
      trunc(days_late * rate * @monday_late_fee)
    else
      days_late * rate
    end
  end
end
