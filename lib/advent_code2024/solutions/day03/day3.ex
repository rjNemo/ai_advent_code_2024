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
    cond do
      # Check if it looks like a file path and try to read it
      String.contains?(input, "/") and not String.contains?(input, "\n") ->
        case File.read(input) do
          {:ok, content} -> solve_content(content)
          {:error, reason} -> {:error, reason}
        end
      
      # Treat as direct content
      true -> 
        solve_content(input)
    end
  end

  @doc """
  Solve part 2 of the challenge
  """
  def solve_part2(input \\ @default_input)
  def solve_part2(""), do: {:error, :no_input}
  def solve_part2(input) when is_binary(input) and input != "" do
    cond do
      # Check if it looks like a file path and try to read it
      String.contains?(input, "/") and not String.contains?(input, "\n") ->
        case File.read(input) do
          {:ok, content} -> solve_part2_content(content)
          {:error, reason} -> {:error, reason}
        end
      
      # Treat as direct content
      true -> 
        solve_part2_content(input)
    end
  end

  # Private functions

  defp solve_content(""), do: {:error, :no_input}
  defp solve_content(content) when is_binary(content) and content != "" do
    result =
      ~r/mul\((\d{1,3}),(\d{1,3})\)/
      |> Regex.scan(content, capture: :all_but_first)
      |> Enum.map(fn [x, y] -> 
        with {x_int, ""} <- Integer.parse(x),
             {y_int, ""} <- Integer.parse(y) do
          x_int * y_int
        else
          _ -> 0
        end
      end)
      |> Enum.sum()

    {:ok, result}
  end

  defp solve_part2_content(""), do: {:error, :no_input}
  defp solve_part2_content(content) when is_binary(content) and content != "" do
    {result, _} = process_multiplications(content)
    {:ok, result}
  end

  defp process_multiplications(content) do
    # Split content into tokens that match either multiplication or control instructions
    tokens = Regex.scan(~r/(?:mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\))|(?:do|don't)\(\)/, content)
             |> List.flatten()
             |> Enum.filter(&(&1 in ["do()", "don't()"] or String.starts_with?(&1, "mul(")))

    # Process tokens in order, tracking multiplication state
    tokens
    |> Enum.reduce({0, true}, fn token, {sum, multiply_enabled} ->
      cond do
        token == "do()" ->
          {sum, true}
        token == "don't()" ->
          {sum, false}
        String.starts_with?(token, "mul") && multiply_enabled ->
          [n1, n2] = Regex.run(~r/mul\((\d{1,3}),(\d{1,3})\)/, token, capture: :all_but_first)
                    |> Enum.map(&String.to_integer/1)
          {sum + n1 * n2, multiply_enabled}
        true ->
          {sum, multiply_enabled}
      end
    end)
  end
end
