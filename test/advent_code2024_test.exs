defmodule AdventCode2024Test do
  use ExUnit.Case
  doctest AdventCode2024

  test "delegates to solution modules" do
    assert function_exported?(AdventCode2024, :solve_day1, 1)
    assert function_exported?(AdventCode2024, :solve_day1_part2, 1)
  end
end
