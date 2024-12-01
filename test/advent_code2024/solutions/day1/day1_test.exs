defmodule AdventCode2024.Solutions.Day1Test do
  use ExUnit.Case
  alias AdventCode2024.Solutions.Day1

  @test_input "test/fixtures/day1/input.txt"

  setup do
    # Ensure the fixtures directory exists
    File.mkdir_p!("test/fixtures/day1")
    
    # Create test input file
    test_content = """
    1 2
    3 4
    5 6
    """
    File.write!(@test_input, test_content)

    on_exit(fn ->
      File.rm!(@test_input)
    end)
  end

  test "solves day 1 puzzle with test input" do
    assert {:ok, result} = Day1.solve(@test_input)
    assert is_integer(result)
  end

  test "solves day 1 part 2 puzzle with test input" do
    assert {:ok, result} = Day1.solve_part2(@test_input)
    assert is_integer(result)
  end
end
