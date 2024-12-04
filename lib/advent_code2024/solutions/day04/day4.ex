defmodule AdventCode2024.Solutions.Day04 do
  @behaviour AdventCode2024.Solution

  @default_input "priv/inputs/day04/input.txt"

  def count_word_occurrences(grid, word) when is_list(grid) do
    grid
    |> Enum.map(&String.graphemes/1)
    |> find_word(String.graphemes(word))
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

  defp find_word?(grid, word_chars, {row, col}, {d_row, d_col}) do
    word_chars
    |> Enum.with_index()
    |> Enum.all?(fn {char, i} ->
      new_row = row + i * d_row
      new_col = col + i * d_col
      within_bounds?(grid, new_row, new_col) && Enum.at(Enum.at(grid, new_row), new_col) == char
    end)
  end

  defp within_bounds?(grid, row, col) do
    row >= 0 and row < length(grid) and col >= 0 and col < length(Enum.at(grid, 0))
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

  def count_x_mas(grid) do
    processed_grid = Enum.map(grid, &String.graphemes/1)

    processed_grid
    |> Enum.with_index()
    |> Enum.reduce(0, fn {row, row_idx}, acc ->
      row
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {cell, col_idx}, acc_inner ->
        if cell == "A" do  # Start from the center A
          acc_inner + check_x_patterns(processed_grid, {row_idx, col_idx})
        else
          acc_inner
        end
      end)
    end)
  end

  defp check_x_patterns(grid, {row, col}) do
    # Check both 1-step and 2-step patterns
    [1, 2]
    |> Enum.reduce(0, fn step, acc ->
      if check_x_pattern(grid, {row, col}, step) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp check_x_pattern(grid, {row, col}, step) do
    # Check if we can form an X pattern with MAS on both diagonals
    check_diagonal(grid, {row, col}, {-step, -step}, {step, step}) and  # top-left to bottom-right
    check_diagonal(grid, {row, col}, {-step, step}, {step, -step})      # top-right to bottom-left
  end

  defp check_diagonal(grid, {center_row, center_col}, {top_dr, top_dc}, {bottom_dr, bottom_dc}) do
    # Check top part and bottom part
    top_row = center_row + top_dr
    top_col = center_col + top_dc
    bottom_row = center_row + bottom_dr
    bottom_col = center_col + bottom_dc

    within_bounds?(grid, top_row, top_col) and
    within_bounds?(grid, bottom_row, bottom_col) and
    (
      # Check normal orientation (M at top, S at bottom)
      (Enum.at(Enum.at(grid, top_row), top_col) == "M" and
       Enum.at(Enum.at(grid, bottom_row), bottom_col) == "S") or
      # Check upside down orientation (S at top, M at bottom)
      (Enum.at(Enum.at(grid, top_row), top_col) == "S" and
       Enum.at(Enum.at(grid, bottom_row), bottom_col) == "M")
    )
  end

  @doc """
  Reads a grid from a file and counts the occurrences of a word using `count_word/2`.

  ## Parameters
  - file_path: The path to the file containing the grid.
  - word: The word to be searched for.

  ## Returns
  - The number of times the word is found in the grid.
  """
  def count_word_from_file(file_path, word) do
    file_path
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.graphemes/1)
    |> count_word_occurrences(word)
  end
end
