defmodule AdventCode2024.Solutions.Day2 do
  @moduledoc """
  Solution for Day 2: Red-Nosed Reports
  """

  @default_input "priv/inputs/day02/input.txt"

  @doc """
  Analyzes reactor reports to count how many are safe according to the rules.
  Returns {:ok, count} for valid input or {:error, reason} for invalid input.
  """
  def solve(input \\ @default_input)
  def solve(""), do: {:error, :no_valid_reports}
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

  defp solve_content(""), do: {:error, :no_valid_reports}
  defp solve_content(content) when is_binary(content) and content != "" do
    lines = String.split(content, "\n", trim: true)

    with {:ok, reports} <- parse_reports(lines) do
      safe_count = Enum.count(reports, &safe_report?/1)
      {:ok, safe_count}
    end
  end

  defp parse_reports(lines) do
    reports = Enum.map(lines, &parse_line/1)

    if Enum.all?(reports, &is_list/1) do
      {:ok, reports}
    else
      {:error, :invalid_format}
    end
  end

  defp parse_line(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(fn num ->
      case Integer.parse(num) do
        {n, ""} -> n
        _ -> nil
      end
    end)
    |> then(fn nums ->
      if Enum.any?(nums, &is_nil/1), do: nil, else: nums
    end)
  end

  defp safe_report?(levels) do
    differences =
      Enum.chunk_every(levels, 2, 1, :discard)
      |> Enum.map(fn [a, b] -> b - a end)

    case differences do
      [] ->
        false

      diffs ->
        all_increasing?(diffs) or all_decreasing?(diffs)
    end
  end

  defp all_increasing?(diffs) do
    Enum.all?(diffs, fn diff -> diff > 0 and diff <= 3 end)
  end

  defp all_decreasing?(diffs) do
    Enum.all?(diffs, fn diff -> diff < 0 and diff >= -3 end)
  end

  @doc """
  Analyzes reactor reports with Problem Dampener active to count safe reports.
  A report is safe if it's already safe or becomes safe after removing one number.
  Returns {:ok, count} for valid input or {:error, reason} for invalid input.
  """
  def solve_part2(input \\ @default_input)
  def solve_part2(""), do: {:error, :no_valid_reports}
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

  defp solve_part2_content(""), do: {:error, :no_valid_reports}
  defp solve_part2_content(content) when is_binary(content) and content != "" do
    lines = String.split(content, "\n", trim: true)

    with {:ok, reports} <- parse_reports(lines) do
      safe_count = Enum.count(reports, &safe_with_dampener?/1)
      {:ok, safe_count}
    end
  end

  defp safe_with_dampener?(levels) do
    # Check if already safe without removal
    if safe_report?(levels) do
      true
    else
      # Try removing each number one at a time
      0..(length(levels) - 1)
      |> Enum.any?(fn index ->
        levels
        |> List.delete_at(index)
        |> safe_report?()
      end)
    end
  end
end
