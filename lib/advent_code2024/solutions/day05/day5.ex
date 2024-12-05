defmodule AdventCode2024.Solutions.Day5 do
  @moduledoc """
  Day 5: Solution for Advent of Code 2024
  """

  @behaviour AdventCode2024.Solution

  @default_input "priv/inputs/day05/input.txt"

  @doc """
  Solve part 1 of the challenge
  """
  def solve(input_file \\ @default_input)
  def solve(""), do: {:error, :no_input}

  def solve(input_file) when is_binary(input_file) and input_file != "" do
    case File.read(input_file) do
      {:ok, content} -> solve_content(content)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Solve part 2 of the challenge
  """
  def solve_part2(input_file \\ @default_input)
  def solve_part2(""), do: {:error, :no_input}

  def solve_part2(input_file) when is_binary(input_file) and input_file != "" do
    case File.read(input_file) do
      {:ok, content} -> solve_part2_content(content)
      {:error, reason} -> {:error, reason}
    end
  end

  # Private functions

  defp solve_content(""), do: {:error, :no_input}

  defp solve_content(content) when is_binary(content) and content != "" do
    result =
      content
      |> parse_input()

    {:ok, result}
  end

  defp solve_part2_content(""), do: {:error, :no_input}

  defp solve_part2_content(content) when is_binary(content) and content != "" do
    result =
      content
      |> parse_input()

    {:ok, result}
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end
end
