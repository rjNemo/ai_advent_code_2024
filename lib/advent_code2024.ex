defmodule AdventCode2024 do
  @moduledoc """
  Documentation for `AdventCode2024`.
  """

  defdelegate solve_day1(input_file \\ "priv/inputs/day1/input.txt"),
    to: AdventCode2024.Solutions.Day1,
    as: :solve

  defdelegate solve_day1_part2(input_file \\ "priv/inputs/day1/input.txt"),
    to: AdventCode2024.Solutions.Day1,
    as: :solve_part2
end
