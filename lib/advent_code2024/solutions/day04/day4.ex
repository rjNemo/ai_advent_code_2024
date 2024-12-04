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
    # Get the center character first
    center = get_char(grid, row, col)
    if center != "A", do: false,
    else: check_diagonals(grid, row, col)
  end

  defp check_diagonals(grid, row, col) do
    # Define the four diagonal directions from center
    diagonals = [
      [{-1, -1}, {1, 1}],  # top-left to bottom-right
      [{-1, 1}, {1, -1}],  # top-right to bottom-left
    ]

    # For each diagonal pair, check if either forms a valid MAS pattern
    Enum.any?(diagonals, fn [d1, d2] ->
      chars1 = get_diagonal_chars(grid, row, col, d1)
      chars2 = get_diagonal_chars(grid, row, col, d2)
      
      case {chars1, chars2} do
        {[c1, "A", c3], [c4, "A", c6]} when not is_nil(c1) and not is_nil(c3) and not is_nil(c4) and not is_nil(c6) ->
          (is_mas?(c1, c3) and is_mas?(c4, c6)) or
          (is_mas?(c3, c1) and is_mas?(c6, c4))
        _ -> false
      end
    end)
  end

  defp get_diagonal_chars(grid, row, col, {dr, dc}) do
    [
      get_char(grid, row - dr, col - dc),
      get_char(grid, row, col),
      get_char(grid, row + dr, col + dc)
    ]
  end

  defp get_char(grid, row, col) do
    if within_bounds?(grid, row, col) do
      Enum.at(Enum.at(grid, row), col)
    end
  end

  defp is_mas?(first, last) do
    first == "M" and last == "S"
  end
end
