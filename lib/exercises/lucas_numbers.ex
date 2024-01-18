defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """

  # def generate(1), do: [2]
  # def generate(2), do: [2, 1]

  # def generate(count) do
  #   Stream.iterate([2, 1], &(&1 ++ [Enum.at(&1, -1) + Enum.at(&1, -2)]))
  #   |> Enum.take(count)
  #   |> Enum.find(&(length(&1) == count))
  # end

  def generate(count) when is_integer(count) and count >= 1 do
    Stream.unfold({2, 1}, fn {a, b} -> {a, {b, a + b}} end)
    |> Enum.take(count)
  end

  def generate(_) do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end
end

IO.inspect(LucasNumbers.generate(4))
