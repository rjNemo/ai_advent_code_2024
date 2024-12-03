# Day 3: Mull It Over

## Problem Description

The North Pole Toboggan Rental Shop's computers are having issues with corrupted
memory.
The program is trying to multiply numbers but the instructions are jumbled up.

## Rules

- Valid instructions are in the format `mul(X,Y)` where X and Y are 1-3 digit numbers
- Example: `mul(44,46)` multiplies 44 by 46 to get 2024
- Invalid instructions should be ignored, examples:
  - `mul(4*`
  - `mul(6,9!`
  - `?(12,34)`
  - `mul ( 2 , 4 )`

## Example

Given the corrupted memory:

```txt
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
```

Only these instructions are valid:

- mul(2,4)
- mul(5,5)
- mul(11,8)
- mul(8,5)

```sh
Total = (2*4) + (5*5) + (11*8) + (8*5) = 161
```

## Task

Scan the corrupted memory for valid mul instructions and sum their results.

--- Part Two ---
As you scan through the corrupted memory, you notice that some of the conditional statements are also still intact. If you handle some of the uncorrupted conditional statements in the program, you might be able to get an even more accurate result.

There are two new instructions you'll need to handle:

The do() instruction enables future mul instructions.
The don't() instruction disables future mul instructions.
Only the most recent do() or don't() instruction applies. At the beginning of the program, mul instructions are enabled.

For example:

xmul(2,4)&mul[3,7]!^don't()\_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
This corrupted memory is similar to the example from before, but this time the mul(5,5) and mul(11,8) instructions are disabled because there is a don't() instruction before them. The other mul instructions function normally, including the one at the end that gets re-enabled by a do() instruction.

This time, the sum of the results is 48 (2*4 + 8*5).

Handle the new instructions; what do you get if you add up all of the results of just the enabled multiplications?
