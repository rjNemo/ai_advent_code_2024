defmodule AdventCode2024.Solutions.Day2Test do
  use ExUnit.Case
  alias AdventCode2024.Solutions.Day2

  describe "solve/1" do
    test "correctly identifies safe reports from example data" do
      input = """
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
      """

      assert Day2.solve(input) == {:ok, 2}
    end

    test "identifies a single safe decreasing report" do
      input = "7 6 4 2 1\n"
      assert Day2.solve(input) == {:ok, 1}
    end

    test "identifies a single safe increasing report" do
      input = "1 3 6 7 9\n"
      assert Day2.solve(input) == {:ok, 1}
    end

    test "identifies an unsafe report with too large increase" do
      input = "1 2 7 8 9\n"
      assert Day2.solve(input) == {:ok, 0}
    end

    test "identifies an unsafe report with too large decrease" do
      input = "9 7 6 2 1\n"
      assert Day2.solve(input) == {:ok, 0}
    end

    test "identifies an unsafe report with direction change" do
      input = "1 3 2 4 5\n"
      assert Day2.solve(input) == {:ok, 0}
    end

    test "identifies an unsafe report with no change between numbers" do
      input = "8 6 4 4 1\n"
      assert Day2.solve(input) == {:ok, 0}
    end

    test "handles empty input" do
      assert Day2.solve("") == {:error, :no_valid_reports}
    end

    test "handles invalid input format" do
      assert Day2.solve("not numbers") == {:error, :invalid_format}
    end
  end

  describe "solve_part2/1" do
    test "correctly identifies safe reports with Problem Dampener from example data" do
      input = """
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
      """

      assert Day2.solve_part2(input) == {:ok, 4}
    end

    test "identifies a report made safe by removing middle number" do
      input = "1 3 2 4 5\n"
      assert Day2.solve_part2(input) == {:ok, 1}
    end

    test "identifies a report made safe by removing duplicate number" do
      input = "8 6 4 4 1\n"
      assert Day2.solve_part2(input) == {:ok, 1}
    end

    test "identifies an already safe report without needing removal" do
      input = "1 3 6 7 9\n"
      assert Day2.solve_part2(input) == {:ok, 1}
    end

    test "identifies an unsafe report that can't be made safe" do
      input = "1 2 7 8 9\n"
      assert Day2.solve_part2(input) == {:ok, 0}
    end

    test "handles empty input for part 2" do
      assert Day2.solve_part2("") == {:error, :no_valid_reports}
    end

    test "handles invalid input format for part 2" do
      assert Day2.solve_part2("not numbers") == {:error, :invalid_format}
    end
  end
end
