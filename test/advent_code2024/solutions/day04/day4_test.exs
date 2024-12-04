defmodule AdventCode2024.Solutions.Day04Test do
  use ExUnit.Case
  alias AdventCode2024.Solutions.Day04

  @example_grid [
    "MMMSXXMASM",
    "MSAMXMSMSA",
    "AMXSXMAAMM",
    "MSAMASMSMX",
    "XMASAMXAMM",
    "XXAMMXXAMA",
    "SMSMSASXSS",
    "SAXAMASAAA",
    "MAMMMXMMMM",
    "MXMXAXMASX"
  ]

  test "count occurrences of XMAS in word search" do
    expected_count = 18
    actual_count = Day04.count_word_occurrences(@example_grid, "XMAS")
    assert actual_count == expected_count
  end
end
