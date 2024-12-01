defmodule AdventCode2024Test do
  use ExUnit.Case
  doctest AdventCode2024

  describe "Day 1: Historian Hysteria" do
    test "solves day 1 puzzle with actual input file" do
      assert {:ok, result} = AdventCode2024.solve_day1()
      assert is_integer(result)
    end

    test "handles missing input file" do
      assert {:error, :enoent} = AdventCode2024.solve_day1("nonexistent.txt")
    end

    test "parses input string correctly" do
      input = "1\t2\n3\t4\n5\t6"
      assert {[1, 3, 5], [2, 4, 6]} = AdventCode2024.parse_input(input)
    end
    test "calculates total distance between two lists using example input" do
      left_list = [3, 4, 2, 1, 3, 3]
      right_list = [4, 3, 5, 3, 9, 3]
      
      assert AdventCode2024.calculate_total_distance(left_list, right_list) == 11
    end

    test "handles empty lists" do
      assert AdventCode2024.calculate_total_distance([], []) == 0
    end

    test "handles single element lists" do
      assert AdventCode2024.calculate_total_distance([1], [3]) == 2
    end
  end
end
