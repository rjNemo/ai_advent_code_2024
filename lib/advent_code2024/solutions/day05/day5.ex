defmodule AdventCode2024.Solutions.Day05 do
  @moduledoc """
  Day 5: Solution for Advent of Code 2024
  """

  @behaviour AdventCode2024.Solution

  @impl true
  def solve(""), do: {:error, :no_input}

  def solve(path \\ "priv/inputs/day05/input.txt") do
    case File.read(path) do
      {:ok, content} -> solve_content(content)
      {:error, :enoent} -> {:error, :enoent}
      _ -> {:error, :no_input}
    end
  end

  def solve_content(""), do: {:error, :no_input}

  def solve_content(content) do
    {rules, updates} = parse_input(content)
    valid_updates = Enum.filter(updates, &is_valid_update?(&1, rules))
    sum = valid_updates |> Enum.map(&get_middle_number/1) |> Enum.sum()
    {:ok, sum}
  end

  @impl true
  def solve_part2(""), do: {:error, :no_input}

  def solve_part2(path \\ "priv/inputs/day05/input.txt") do
    case File.read(path) do
      {:ok, content} -> solve_part2_content(content)
      {:error, :enoent} -> {:error, :enoent}
      _ -> {:error, :no_input}
    end
  end

  def solve_part2_content(""), do: {:error, :no_input}

  def solve_part2_content(content) do
    {rules, updates} = parse_input(content)
    invalid_updates = Enum.reject(updates, &is_valid_update?(&1, rules))

    sum =
      invalid_updates
      |> Enum.map(&order_update(&1, rules))
      |> Enum.map(&get_middle_number/1)
      |> Enum.sum()

    {:ok, sum}
  end

  defp parse_input(content) do
    [rules_str, updates_str] = String.split(content, "\n\n", trim: true)
    rules = parse_rules(rules_str)
    updates = parse_updates(updates_str)
    {rules, updates}
  end

  defp parse_rules(rules_str) do
    rules_str
    |> String.split("\n", trim: true)
    |> Enum.map(fn rule ->
      [first, second] = String.split(rule, "|")
      {String.to_integer(first), String.to_integer(second)}
    end)
  end

  defp parse_updates(updates_str) do
    updates_str
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp is_valid_update?(update, rules) do
    update
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> is_valid_order?(a, b, rules) end)
  end

  defp is_valid_order?(a, b, rules) do
    not Enum.any?(rules, fn {x, y} -> x == b and y == a end)
  end

  defp get_middle_number(list) do
    middle_index = div(length(list), 2)
    Enum.at(list, middle_index)
  end

  defp order_update(update, rules) do
    update
    |> Enum.sort(fn a, b ->
      case {should_come_before?(a, b, rules), should_come_before?(b, a, rules)} do
        {true, false} -> true
        {false, true} -> false
        _ -> a > b
      end
    end)
  end

  defp should_come_before?(a, b, rules) do
    Enum.any?(rules, fn {x, y} -> x == a and y == b end)
  end
end
