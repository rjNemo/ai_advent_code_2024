defmodule AdventCode2024Test do
  use ExUnit.Case
  doctest AdventCode2024

  test "delegates day1 solutions to Day1 module" do
    assert {:ok, result} = AdventCode2024.solve_day1()
    assert is_integer(result)
    
    assert {:ok, result} = AdventCode2024.solve_day1_part2() 
    assert is_integer(result)
  end
end
