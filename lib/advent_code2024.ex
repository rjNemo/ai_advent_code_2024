defmodule AdventCode2024 do
  @moduledoc """
  Documentation for `AdventCode2024`.
  """

  @doc """
  Reads the input file for day 1 and calculates the total distance between the two lists.
  Returns {:ok, result} if successful, {:error, reason} if there's an error.
  """
  def solve_day1(input_file \\ "day1/input.txt") do
    case File.read(input_file) do
      {:ok, content} ->
        {left_list, right_list} = parse_input(content)
        result = calculate_total_distance(left_list, right_list)
        {:ok, result}
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Parses the input string into two lists of numbers.
  Input format is expected to be tab-separated numbers, one pair per line.
  """
  def parse_input(content) do
    {left, right} =
      content
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ~r/\s+/, trim: true))
      |> Enum.map(fn [left, right] -> 
        {String.to_integer(left), String.to_integer(right)}
      end)
      |> Enum.unzip()

    {left, right}
  end

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

  @doc """
  Calculates the similarity score between two lists.
  For each number in the left list, multiplies it by the number of times it appears in the right list.
  Returns the sum of all these products.

  ## Examples

      iex> AdventCode2024.calculate_similarity_score([3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3])
      31

  """
  def calculate_similarity_score(left_list, right_list) do
    frequencies = Enum.frequencies(right_list)
    
    left_list
    |> Enum.map(fn num -> 
      num * Map.get(frequencies, num, 0)
    end)
    |> Enum.sum()
  end
end
