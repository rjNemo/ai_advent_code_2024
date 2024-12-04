defmodule AdventCode2024.Solutions.Day04 do
  @behaviour AdventCode2024.Solution

  @default_input "priv/inputs/day04/input.txt"

  def count_word_occurrences(grid, word) do
    grid
    |> Enum.map(&String.graphemes/1)
    |> find_word(word)
  end

  defp find_word(grid, word) do
    directions = [
      # Right
      {0, 1},
      # Down
      {1, 0},
      # Left
      {0, -1},
      # Up
      {-1, 0},
      # Down-right diagonal
      {1, 1},
      # Up-left diagonal
      {-1, -1},
      # Down-left diagonal
      {1, -1},
      # Up-right diagonal
      {-1, 1}
    ]

    grid
    |> Enum.with_index()
    |> Enum.reduce(0, fn {row, row_idx}, acc ->
      row
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {_, col_idx}, acc_inner ->
        acc_inner + count_word_from(grid, word, {row_idx, col_idx}, directions)
      end)
    end)
  end

  defp count_word_from(grid, word, {row, col}, directions) do
    directions
    |> Enum.reduce(0, fn direction, acc ->
      if find_word?(grid, word, {row, col}, direction) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp find_word?(grid, word, {row, col}, {d_row, d_col}) do
    word
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.all?(fn {char, i} ->
      new_row = row + i * d_row
      new_col = col + i * d_col
      within_bounds?(grid, new_row, new_col) && Enum.at(Enum.at(grid, new_row), new_col) == char
    end)
  end

  defp within_bounds?(grid, row, col) do
    row >= 0 && row < length(grid) && col >= 0 && col < length(Enum.at(grid, 0))
  end

  @doc """
  Reads a grid from a file and counts the occurrences of a word using `count_word/2`.

  ## Parameters
  - file_path: The path to the file containing the grid.
  - word: The word to be searched for.

  ## Returns
  - The number of times the word is found in the grid.
  """
  def solve(file_path \\ @default_input) do
    file_path
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> count_word_occurrences("XMAS")
  end

  def solve_part2(_input_file) do
  end

  def count_x_mas(grid, word \\ "MAS") do
    directions = [
      # Down
      {1, 0},
      # Right
      {0, 1},
      # Down-right diagonal
      {1, 1},
      # Down-left diagonal
      {1, -1}
    ]

    grid
    |> Enum.with_index()
    |> Enum.reduce(0, fn {row, row_idx}, acc ->
      row
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {_, col_idx}, acc_inner ->
        acc_inner + count_xmas_from(grid, word, {row_idx, col_idx}, directions)
      end)
    end)
  end

  defp count_xmas_from(grid, _word, {row, col}, directions) do
    directions
    |> Enum.reduce(0, fn direction, acc ->
      if find_xmas?(grid, {row, col}, direction) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp find_xmas?(grid, {row, col}, {d_row, d_col}) do
    # Define the positions for the X shape
    positions = [
      {row, col},
      {row + d_row, col + d_col},
      {row + 2 * d_row, col + 2 * d_col},
      {row + d_row, col - d_col}
    ]

    # Check if all positions contain the correct letters for "MAS"
    Enum.with_index(positions)
    |> Enum.all?(fn {{r, c}, idx} ->
      within_bounds?(grid, r, c) && Enum.at(Enum.at(grid, r), c) == String.at("MAS", idx)
    end)
  end
end
