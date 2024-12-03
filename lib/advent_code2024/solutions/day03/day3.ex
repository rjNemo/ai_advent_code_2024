defmodule AdventCode2024.Solutions.Day03 do
  @moduledoc """
  Solution for Advent of Code 2024, Day 3
  """

  @behaviour AdventCode2024.Solution

  @default_input "lib/advent_code2024/solutions/day03/input.txt"

  @doc """
  Solve part 1 of the challenge
  """
  def solve(input \\ @default_input)
  def solve(""), do: {:error, :no_input}
  def solve(input) when is_binary(input) and input != "" do
    if String.contains?(input, "\n") or !String.contains?(input, "/") do
      # Input is content
      solve_content(input)
    else
      # Input is file path
      case File.read(input) do
        {:ok, content} -> solve_content(content)
        {:error, reason} -> {:error, reason}
      end
    end
  end

  @doc """
  Solve part 2 of the challenge
  """
  def solve_part2(input \\ @default_input)
  def solve_part2(""), do: {:error, :no_input}
  def solve_part2(input) when is_binary(input) and input != "" do
    if String.contains?(input, "\n") or !String.contains?(input, "/") do
      # Input is content
      solve_part2_content(input)
    else
      # Input is file path
      case File.read(input) do
        {:ok, content} -> solve_part2_content(content)
        {:error, reason} -> {:error, reason}
      end
    end
  end

  # Private functions

  defp solve_content(""), do: {:error, :no_input}
  defp solve_content(content) when is_binary(content) and content != "" do
    # TODO: Implement solution for part 1
    {:ok, 0}
  end

  defp solve_part2_content(""), do: {:error, :no_input}
  defp solve_part2_content(content) when is_binary(content) and content != "" do
    # TODO: Implement solution for part 2
    {:ok, 0}
  end
end
