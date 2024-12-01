# Advent of Code 2024

This repository contains solutions for the [Advent of Code 2024](https://adventofcode.com/2024)
programming puzzles, implemented in Elixir.

## AI Assistance

This project was developed with the assistance of AI tools:

- [Aider](https://github.com/paul-gauthier/aider) - AI coding assistant
- Claude (Sonnet) - Anthropic's AI model for pair programming

The AI tools helped with:

- Code structure and organization
- Problem-solving approaches
- Testing strategies
- Documentation

## Project Description

Advent of Code is an annual set of Christmas-themed programming challenges that follow
an advent calendar. Each day, a new two-part puzzle is released. This project provides
solutions to these puzzles using Elixir, demonstrating functional programming concepts
and Elixir-specific features.

## Technology Stack

- **Language**: Elixir 1.17

## Getting Started

### Prerequisites

- Elixir 1.17 or later
- Erlang/OTP 24 or later

### Installation

1. Clone the repository:

```sh
git clone https://github.com/yourusername/advent_code_2024.git
cd advent_code_2024
```

2. Fetch dependencies:

```sh
mix deps.get
```

3. Compile the project:

```sh
mix compile
```

## Usage

### Running Solutions

To run a specific day's solution:

```sh
# Run Day 1 solution
mix run -e "AdventCode2024.solve_day1() |> IO.inspect()"

# Run Day 1 Part 2 solution
mix run -e "AdventCode2024.solve_day1_part2() |> IO.inspect()"
```

### Running Tests

To run all tests:

```sh
mix test
```

To run tests for a specific day:

```sh
mix test test/advent_code2024_test.exs
```

## Project Structure

```sh
.
├── lib/
│   ├── advent_code2024.ex          # Main module
│   └── advent_code2024/
│       └── day1.ex                 # Day 1 solution
├── test/                           # Test files
└── day1/                           # Input files
    └── input.txt
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-solution`)
3. Commit your changes (`git commit -am 'Add amazing solution'`)
4. Push to the branch (`git push origin feature/amazing-solution`)
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
