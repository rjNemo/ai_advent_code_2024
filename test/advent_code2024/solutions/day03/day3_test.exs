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

    test "handles single valid multiplication" do
      input = "mul(2,4)"
      assert Day03.solve(input) == {:ok, 8}
    end

    test "handles multiple valid multiplications" do
      input = "mul(2,4)mul(5,5)"
      assert Day03.solve(input) == {:ok, 33}
    end

    test "ignores invalid multiplication formats" do
      input = "mul(4*mul(6,9!?(12,34)mul(2,4)"
      assert Day03.solve(input) == {:ok, 8}
    end

    test "solves example from README" do
      input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
      assert Day03.solve(input) == {:ok, 161}
    end

    test "handles numbers up to 3 digits" do
      input = "mul(123,456)mul(1,1)"
      assert Day03.solve(input) == {:ok, 56089}
    end

    test "ignores multiplications with spaces" do
      input = "mul ( 2 , 4 )mul(2,4)"
      assert Day03.solve(input) == {:ok, 8}
    end
  end

  describe "solve_part2/1" do
    test "returns error for empty input" do
      assert Day03.solve_part2("") == {:error, :no_input}
    end

    @tag :skip
    test "returns error for invalid file" do
      assert Day03.solve_part2("nonexistent.txt") == {:error, :enoent}
    end
  end
end
