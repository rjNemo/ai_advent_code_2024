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
