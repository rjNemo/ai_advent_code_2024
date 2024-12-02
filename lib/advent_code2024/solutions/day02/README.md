# Day 2: Red-Nosed Reports

## Problem Description

The engineers at the Red-Nosed Reindeer nuclear fusion/fission plant need help analyzing
unusual data from their reactor. The data consists of reports, with each report containing
a list of numbers called levels.

### Rules for Safe Reports

A report is considered safe if it meets both of these criteria:

1. The levels are either all increasing or all decreasing
2. Any two adjacent levels differ by at least one and at most three

### Example

```csv
7 6 4 2 1  # Safe (all decreasing by 1 or 2)
1 2 7 8 9  # Unsafe (2->7 increases by 5)
9 7 6 2 1  # Unsafe (6->2 decreases by 4)
1 3 2 4 5  # Unsafe (increasing then decreasing)
8 6 4 4 1  # Unsafe (4->4 no change)
1 3 6 7 9  # Safe (all increasing by 1-3)
```

### Part 1 Challenge

Count how many reports in the input data are safe according to the rules above.

### Input Format

Each line contains space-separated integers representing the levels in a report.

### Example Solution

In the example above, 2 reports are safe.
