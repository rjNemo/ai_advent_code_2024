# Coding Challenge: Ceres Search

## Problem Summary

You are presented with a word search puzzle where you must find all occurrences of
the word "XMAS". The word can appear in various directions and orientations, including:

- Horizontal (left-to-right and right-to-left)
- Vertical (top-to-bottom and bottom-to-top)
- Diagonal (both directions)
- Overlapping with other words

## Example Puzzle

Below is a simplified word search grid where irrelevant characters are replaced
with `.`:

```txt
..X...
.SAMX.
.A..A.
XMAS.S
.X....
```

In this grid, "XMAS" can appear in multiple ways.

## Larger Example

For the following complete grid:

```txt
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
```

The word "XMAS" occurs **18 times**. Visualizing the grid with only the letters
in "XMAS" highlighted:

```txt
....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX
```

## Objective

For the given puzzle input, calculate and return the total number of times the word
"XMAS" appears in all possible orientations.

## Notes

- Words can overlap and share characters.
- Input will be a rectangular grid of letters.

Good luck helping the little Elf! 🌟

## Part 2 Challenge

The Elf looks quizzically at you. Did you misunderstand the assignment?

Looking for the instructions, you flip over the word search to find that this
isn't actually an XMAS puzzle; it's an X-MAS puzzle in which you're supposed to
find two MAS in the shape of an X. One way to achieve that is like this:

```txt
M.S
.A.
M.S
```

Irrelevant characters have again been replaced with `.` in the above diagram.
Within the X, each MAS can be written forwards or backwards.

Here's the same example from before, but this time all of the X-MASes have been
kept instead:

```txt
.M.S......
..A..MSMS.
.M.S.MAA..
..A.ASMSM.
.M.S.M....
..........
S.S.S.S.S.
.A.A.A.A..
M.M.M.M.M.
..........
```

In this example, an X-MAS appears 9 times.

Flip the word search from the instructions back over to the word search side and
try again. How many times does an X-MAS appear?
