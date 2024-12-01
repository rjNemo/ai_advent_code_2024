defmodule AdventCode2024.Solution do
  @moduledoc """
  Behaviour module defining the interface for Advent of Code daily solutions.
  """

  @doc """
  Solves Part 1 of a daily challenge.
  
  ## Parameters
    - input_file: Path to input file
    
  ## Returns
    - `{:ok, result}` where result is the solution
    - `{:error, reason}` if processing fails
  """
  @callback solve(input_file :: String.t()) :: {:ok, any()} | {:error, String.t()}

  @doc """
  Solves Part 2 of a daily challenge.
  
  ## Parameters
    - input_file: Path to input file
    
  ## Returns
    - `{:ok, result}` where result is the solution
    - `{:error, reason}` if processing fails
  """
  @callback solve_part2(input_file :: String.t()) :: {:ok, any()} | {:error, String.t()}
end
