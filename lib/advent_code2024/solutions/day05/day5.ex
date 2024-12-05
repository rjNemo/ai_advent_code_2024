defmodule AdventCode2024.Solutions.Day05 do
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
    {rules, updates} = parse_input(content)

    result =
      updates
      |> Enum.filter(&is_valid_update?(&1, rules))
      |> Enum.map(&get_middle_number/1)
      |> Enum.sum()

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
    [rules_section, updates_section] = String.split(input, "\n\n", trim: true)

    rules = parse_rules(rules_section)
    updates = parse_updates(updates_section)

    {rules, updates}
  end

  defp parse_rules(rules_section) do
    rules_section
    |> String.split("\n", trim: true)
    |> Enum.map(fn rule ->
      [first, second] = String.split(rule, "|")
      {String.to_integer(first), String.to_integer(second)}
    end)
  end

  defp parse_updates(updates_section) do
    updates_section
    |> String.split("\n", trim: true)
    |> Enum.map(fn update ->
      update
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp is_valid_update?(update, rules) do
    # For each pair of numbers in the update, check if they satisfy all applicable rules
    update
    |> Enum.with_index()
    |> Enum.all?(fn {num1, idx1} ->
      update
      |> Enum.with_index()
      |> Enum.all?(fn {num2, idx2} ->
        # Only check pairs where the second number comes after the first
        if idx2 > idx1 do
          # Check if there's a rule requiring num2 to come before num1
          not Enum.any?(rules, fn {first, second} ->
            num1 == second and num2 == first
          end)
        else
          true
        end
      end)
    end)
  end

  defp get_middle_number(update) do
    middle_index = div(length(update), 2)
    Enum.at(update, middle_index)
  end
end
