defmodule AdventCode2024.Day1 do
  @moduledoc """
  Solution for Advent of Code 2024 - Day 1: Historian Hysteria
  """

  def solve(input_file \\ "day1/input.txt") do
    case File.read(input_file) do
      {:ok, content} ->
        {left, right} = parse_input(content)
        result = calculate_total_distance(left, right)
        {:ok, result}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def solve_part2(input_file \\ "day1/input.txt") do
    case File.read(input_file) do
      {:ok, content} ->
        {left, right} = parse_input(content)
        result = calculate_similarity_score(left, right)
        {:ok, result}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp parse_input(content) do
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

  defp calculate_total_distance(left, right) do
    Enum.zip(Enum.sort(left), Enum.sort(right))
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  defp calculate_similarity_score(left, right) do
    frequencies = Enum.frequencies(right)

    left
    |> Enum.map(fn num ->
      num * Map.get(frequencies, num, 0)
    end)
    |> Enum.sum()
  end
end
