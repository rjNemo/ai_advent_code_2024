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

  def count_x_mas(grid) when is_list(grid) do
    # Convert string rows to character grid
    char_grid = Enum.map(grid, &String.graphemes/1)
    rows = length(char_grid)
    cols = length(Enum.at(char_grid, 0))

    # Check each possible center position
    for row <- 1..(rows - 2),
        col <- 1..(cols - 2),
        reduce: 0 do
      acc ->
        if is_x_mas_pattern?(char_grid, {row, col}) do
          acc + 1
        else
          acc
        end
    end
  end

  defp is_x_mas_pattern?(grid, {row, col}) do
    # Define the four possible X patterns (clockwise from top-left)
    patterns = [
      # Top-left to bottom-right + Top-right to bottom-left
      [{-1, -1}, {0, 0}, {1, 1}, {-1, 1}, {0, 0}, {1, -1}],
      # Top-right to bottom-left + Top-left to bottom-right
      [{-1, 1}, {0, 0}, {1, -1}, {-1, -1}, {0, 0}, {1, 1}],
      # Bottom-right to top-left + Bottom-left to top-right
      [{1, 1}, {0, 0}, {-1, -1}, {1, -1}, {0, 0}, {-1, 1}],
      # Bottom-left to top-right + Bottom-right to top-left
      [{1, -1}, {0, 0}, {-1, 1}, {1, 1}, {0, 0}, {-1, -1}]
    ]

    Enum.any?(patterns, fn pattern ->
      check_x_pattern?(grid, {row, col}, pattern)
    end)
  end

  defp check_x_pattern?(grid, {center_row, center_col}, positions) do
    letters = positions
    |> Enum.map(fn {dr, dc} ->
      r = center_row + dr
      c = center_col + dc
      if within_bounds?(grid, r, c) do
        Enum.at(Enum.at(grid, r), c)
      end
    end)

    case letters do
      [m1, a1, s1, m2, a2, s2] when not is_nil(m1) and not is_nil(s1) and not is_nil(m2) and not is_nil(s2) ->
        # Check if we have valid MAS patterns in both diagonals
        (m1 == "M" and a1 == "A" and s1 == "S" and
         m2 == "M" and a2 == "A" and s2 == "S") or
        (s1 == "S" and a1 == "A" and m1 == "M" and
         s2 == "S" and a2 == "A" and m2 == "M")
      _ -> false
    end
  end
end
