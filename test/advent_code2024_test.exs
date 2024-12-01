defmodule AdventCode2024Test do
  use ExUnit.Case
  doctest AdventCode2024

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

  test "delegates day1 solutions to Day1 module" do
    assert {:ok, result} = AdventCode2024.solve_day1(@test_input)
    assert is_integer(result)
    
    assert {:ok, result} = AdventCode2024.solve_day1_part2(@test_input)
    assert is_integer(result)
  end
end
