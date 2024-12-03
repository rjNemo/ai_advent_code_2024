defmodule AdventCode2024.Solutions.Day03Test do
  use ExUnit.Case
  alias AdventCode2024.Solutions.Day03

  describe "solve/1" do
    test "returns error for empty input" do
      assert Day03.solve("") == {:error, :no_input}
    end

    test "returns error for invalid file" do
      assert Day03.solve("nonexistent.txt") == {:error, :enoent}
    end

    # TODO: Add more specific tests for part 1
  end

  describe "solve_part2/1" do
    test "returns error for empty input" do
      assert Day03.solve_part2("") == {:error, :no_input}
    end

    test "returns error for invalid file" do
      assert Day03.solve_part2("nonexistent.txt") == {:error, :enoent}
    end

    # TODO: Add more specific tests for part 2
  end
end
