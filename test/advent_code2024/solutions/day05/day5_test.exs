defmodule AdventCode2024.Solutions.Day5Test do
  use ExUnit.Case
  alias AdventCode2024.Solutions.Day5

  @example_input """
  47|53
  97|13
  97|61
  97|47
  75|29
  61|13
  75|53
  29|13
  97|29
  53|29
  61|53
  97|53
  61|29
  47|13
  75|47
  97|75
  47|61
  75|61
  47|29
  75|13
  53|13

  75,47,61,53,29
  97,61,53,29,13
  75,29,13
  75,97,47,61,53
  61,13,29
  97,13,75,29,47
  """

  describe "solve/1" do
    test "correctly identifies valid updates and sums middle pages" do
      assert {:ok, 143} = Day5.solve_content(@example_input)
    end

    test "returns error for empty input" do
      assert Day5.solve("") == {:error, :no_input}
    end

    test "returns error for invalid file" do
      assert Day5.solve("priv/nonexistent.txt") == {:error, :enoent}
    end

    test "validates first update is in correct order" do
      input = """
      75|47
      75|61
      75|53
      75|29
      47|61
      47|53
      47|29
      61|53
      61|29
      53|29

      75,47,61,53,29
      """
      assert {:ok, 61} = Day5.solve_content(input)
    end

    test "validates second update is in correct order" do
      input = """
      97|13
      97|61
      97|53
      97|29
      61|13
      61|53
      61|29
      53|29
      29|13

      97,61,53,29,13
      """
      assert {:ok, 53} = Day5.solve_content(input)
    end

    test "identifies invalid update due to rule violation" do
      input = """
      97|75

      75,97,47,61,53
      """
      assert {:ok, 0} = Day5.solve_content(input)
    end
  end
end
