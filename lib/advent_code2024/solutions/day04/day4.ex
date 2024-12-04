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

  def solve_part2(input_file \\ @default_input) do
    input_file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
    |> count_x_mas()
  end

  def count_x_mas(grid) do
    processed_grid = Enum.map(grid, &String.graphemes/1)

    processed_grid
    |> Enum.with_index()
    |> Enum.reduce(0, fn {row, row_idx}, acc ->
      row
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {cell, col_idx}, acc_inner ->
        # Start from the center A
        if cell == "A" do
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
    # For a valid X pattern, we need:
    # 1. Both diagonals must have valid MAS patterns
    # 2. The patterns must not share any positions except the center A
    # 3. Both diagonals must be the same length (step)
    top_left = {row - step, col - step}
    top_right = {row - step, col + step}
    bottom_left = {row + step, col - step}
    bottom_right = {row + step, col + step}

    # Check if all positions are within bounds
    # Check both diagonals
    # First diagonal: top-left to bottom-right
    # First diagonal: bottom-right to top-left (reverse)
    # Second diagonal: top-right to bottom-left
    # Second diagonal: bottom-left to top-right (reverse)
    within_bounds?(grid, row - step, col - step) and
      within_bounds?(grid, row - step, col + step) and
      within_bounds?(grid, row + step, col - step) and
      within_bounds?(grid, row + step, col + step) and
      (check_diagonal_pattern(grid, top_left, bottom_right, {row, col}) or
         check_diagonal_pattern(grid, bottom_right, top_left, {row, col})) and
      (check_diagonal_pattern(grid, top_right, bottom_left, {row, col}) or
         check_diagonal_pattern(grid, bottom_left, top_right, {row, col}))
  end

  defp check_diagonal_pattern(
         grid,
         {start_row, start_col},
         {end_row, end_col},
         {center_row, center_col}
       ) do
    start_char = Enum.at(Enum.at(grid, start_row), start_col)
    center_char = Enum.at(Enum.at(grid, center_row), center_col)
    end_char = Enum.at(Enum.at(grid, end_row), end_col)

    # Check if we have M->A->S in this order
    # Or S->A->M in this order
    (start_char == "M" and center_char == "A" and end_char == "S") or
      (start_char == "S" and center_char == "A" and end_char == "M")
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
