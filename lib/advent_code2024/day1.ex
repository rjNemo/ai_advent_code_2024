defmodule AdventCode2024.Day1 do
  @moduledoc """
  Solution for Advent of Code 2024 - Day 1: Historian Hysteria
  """

  @spec solve(String.t()) :: {:ok, integer()} | {:error, String.t()}
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

  @spec solve_part2(String.t()) :: {:ok, integer()} | {:error, String.t()}
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

  @spec parse_input(String.t()) :: {[integer()], [integer()]}
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
