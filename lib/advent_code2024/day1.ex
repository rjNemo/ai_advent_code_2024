defmodule AdventCode2024.Day1 do
  @behaviour AdventCode2024.Solution
  @moduledoc """
  Solution for Advent of Code 2024 - Day 1: Historian Hysteria

  This module processes pairs of numbers from an input file to:
  - Calculate total distance between paired numbers (Part 1)
  - Calculate similarity scores based on frequency matching (Part 2)

  Input file format expects lines with two space-separated integers.
  """

  @type result :: {:ok, integer()} | {:error, String.t()}
  @type number_pair :: {[integer()], [integer()]}

  @doc """
  Solves Part 1 of Day 1 challenge.

  Takes an input file path and calculates the total distance between paired numbers.

  ## Parameters
    - input_file: Path to input file (defaults to "day1/input.txt")

  ## Returns
    - `{:ok, result}` where result is the calculated total distance
    - `{:error, reason}` if file reading fails
  """
  @spec solve(String.t()) :: result()
  def solve(input_file \\ "day1/input.txt") do
    case File.read(input_file) do
      {:ok, content} ->
        case parse_input(content) do
          {:error, reason} -> {:error, reason}
          {left, right} -> 
            result = calculate_total_distance(left, right)
            {:ok, result}
        end
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp valid_line?(line) do
    case String.split(line, ~r/\s+/, trim: true) do
      [left, right] -> match?({:ok, _}, Integer.parse(left)) && match?({:ok, _}, Integer.parse(right))
      _ -> false
    end
  end

  @doc """
  Solves Part 2 of Day 1 challenge.

  Takes an input file path and calculates similarity scores based on number frequencies.

  ## Parameters
    - input_file: Path to input file (defaults to "day1/input.txt")

  ## Returns
    - `{:ok, result}` where result is the similarity score
    - `{:error, reason}` if file reading fails
  """
  @spec solve_part2(String.t()) :: result()
  def solve_part2(input_file \\ "day1/input.txt") do
    case File.read(input_file) do
      {:ok, content} ->
        case parse_input(content) do
          {:error, reason} -> {:error, reason}
          {left, right} -> 
            result = calculate_similarity_score(left, right)
            {:ok, result}
        end
      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec parse_input(String.t()) :: number_pair() | {:error, String.t()}
  defp parse_input(content) do
    lines = String.split(content, "\n", trim: true)
    
    if Enum.all?(lines, &valid_line?/1) do
      {left, right} =
        lines
        |> Enum.map(&String.split(&1, ~r/\s+/, trim: true))
        |> Enum.map(fn [left, right] ->
          {String.to_integer(left), String.to_integer(right)}
        end)
        |> Enum.unzip()

      {left, right}
    else
      {:error, "Invalid input format"}
    end
  end

  @spec calculate_total_distance([integer()], [integer()]) :: integer()
  defp calculate_total_distance(left, right) do
    Enum.zip(Enum.sort(left), Enum.sort(right))
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  @spec calculate_similarity_score([integer()], [integer()]) :: integer()
  defp calculate_similarity_score(left, right) do
    frequencies = Enum.frequencies(right)

    left
    |> Enum.map(&(&1 * Map.get(frequencies, &1, 0)))
    |> Enum.sum()
  end
end
