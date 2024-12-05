defmodule AdventCode2024.Solutions.Day05Test do
  use ExUnit.Case
  alias AdventCode2024.Solutions.Day05

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

  setup_all do
    # Create a temporary file for testing
    path = "test/fixtures/day05/test_input.txt"
    File.mkdir_p!(Path.dirname(path))
    :ok = File.write(path, @example_input)

    on_exit(fn ->
      File.rm!(path)
    end)

    {:ok, test_file: path}
  end

  describe "solve/1" do
    test "correctly identifies valid updates and sums middle pages", %{test_file: path} do
      assert {:ok, 143} = Day05.solve(path)
    end

    test "returns error for empty input" do
      assert Day05.solve("") == {:error, :no_input}
    end

    test "returns error for invalid file" do
      assert Day05.solve("priv/nonexistent.txt") == {:error, :enoent}
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

      path = "test/fixtures/day05/first_update.txt"
      :ok = File.write(path, input)
      assert {:ok, 61} = Day05.solve(path)
      File.rm!(path)
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

      path = "test/fixtures/day05/second_update.txt"
      :ok = File.write(path, input)
      assert {:ok, 53} = Day05.solve(path)
      File.rm!(path)
    end

    test "identifies invalid update due to rule violation" do
      input = """
      97|75

      75,97,47,61,53
      """

      path = "test/fixtures/day05/invalid_update.txt"
      :ok = File.write(path, input)
      assert {:ok, 0} = Day05.solve(path)
      File.rm!(path)
    end
  end
end
