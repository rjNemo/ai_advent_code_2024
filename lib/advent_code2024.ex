defmodule AdventCode2024 do
  @moduledoc """
  Documentation for `AdventCode2024`.
  """

  @doc """
  Calculates the total distance between two lists of numbers.
  Lists are first sorted, then paired up, and the absolute differences are summed.

  ## Examples

      iex> AdventCode2024.calculate_total_distance([3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3])
      11
      iex> AdventCode2024.calculate_total_distance([], [])
      0
      iex> AdventCode2024.calculate_total_distance([1], [3])
      2

  """
  def calculate_total_distance(left_list, right_list) do
    Enum.zip(Enum.sort(left_list), Enum.sort(right_list))
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end
end
