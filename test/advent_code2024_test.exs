defmodule AdventCode2024Test do
  use ExUnit.Case
  doctest AdventCode2024
  alias AdventCode2024.Day1

  describe "Day 1: Historian Hysteria" do
    test "solves day 1 puzzle with actual input file" do
      assert {:ok, result} = AdventCode2024.solve_day1()
      assert is_integer(result)
    end

    test "handles missing input file" do
      assert {:error, :enoent} = AdventCode2024.solve_day1("nonexistent.txt")
    end

  end

  describe "Day 1 Part 2: Similarity Score" do

    test "solves day 1 part 2 puzzle with actual input file" do
      assert {:ok, result} = AdventCode2024.solve_day1_part2()
      assert is_integer(result)
    end
  end
end
