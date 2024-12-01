# Day 1: Historian Hysteria

## Part 1: Distance Calculation

Given pairs of numbers, calculate the total distance between sorted pairs.

### Input Format
Each line contains two space-separated integers.

Example:
```
39687 54930
86219 31559
48536 73145
```

### Algorithm
1. Sort both sequences of numbers
2. Calculate absolute differences between paired numbers
3. Sum all differences

## Part 2: Similarity Score

Calculate similarity scores based on frequency matching between number sequences.

### Algorithm
1. Calculate frequency of numbers in right sequence
2. For each number in left sequence, multiply by its frequency in right sequence
3. Sum all products
