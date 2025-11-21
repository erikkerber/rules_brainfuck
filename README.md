# rules_brainfuck

Bazel rules for building and running Brainfuck programs.

This repository provides Bazel integration for the [brainfuck compiler](https://github.com/fabianishere/brainfuck) using Modern Bazel (Bzlmod).

## Setup

This project uses Modern Bazel with MODULE.bazel. The brainfuck compiler is automatically fetched via `http_archive`.

### Prerequisites

- Bazel 6.0 or later
- GCC or compatible C++ compiler with C++17 support

## Building

Build the brainfuck compiler:

```bash
bazel build //:brainfuck
```

## Usage

### Using the brainfuck_binary rule (Recommended)

The `brainfuck_binary` rule creates a runnable target from a Brainfuck source file:

```python
load("@rules_brainfuck//:defs.bzl", "brainfuck_binary")

brainfuck_binary(
    name = "hello",
    src = "hello.bf",
)
```

Then run it:

```bash
bazel run //:hello
```

See the [examples](examples/) directory for working examples.

### Using the compiler directly

Run a brainfuck program with the compiler:

```bash
bazel run //:brainfuck -- /absolute/path/to/program.bf
```

Or build the compiler and use it directly:

```bash
bazel build //:brainfuck
./bazel-bin/external/+_repo_rules+brainfuck/brainfuck program.bf
```

## API Reference

### brainfuck_binary

Creates a runnable target from a Brainfuck source file.

**Attributes:**

- `name` (string, required): The name of the target
- `src` (label, required): The Brainfuck source file (.bf or .b extension)

**Example:**

```python
brainfuck_binary(
    name = "my_program",
    src = "my_program.bf",
)
```

### brainfuck_test

Tests a Brainfuck program by comparing its output to expected output.

**Attributes:**

- `name` (string, required): The name of the test target
- `src` (label, required): The Brainfuck source file (.bf or .b extension)
- `expected_output` (label, required): File containing the expected output (.txt or .out extension)

**Example:**

```python
brainfuck_test(
    name = "my_program_test",
    src = "my_program.bf",
    expected_output = "my_program_expected.txt",
)
```

Run tests with:
```bash
bazel test //:my_program_test
```

## Project Structure

```
rules_brainfuck/
├── MODULE.bazel          # Modern Bazel module definition
├── BUILD                 # Root BUILD file with aliases
├── .bazelrc             # Bazel configuration
├── brainfuck.bzl        # Brainfuck rule implementations
├── defs.bzl             # Public API exports
├── external/
│   ├── BUILD            # Makes external a package
│   └── brainfuck.BUILD  # BUILD file for external brainfuck repo
├── examples/
│   ├── BUILD            # Example targets using brainfuck_binary
│   ├── hello_world.bf   # Classic Hello World
│   ├── simple_loop.bf   # Example with loops
│   └── beer.bf          # 99 Bottles of Beer song (1752 instructions!)
└── tests/
    ├── BUILD            # Test targets using brainfuck_test
    ├── hello_world_expected.txt
    ├── simple_loop_expected.txt
    ├── print_a.bf       # Simple test program
    └── print_a_expected.txt
```

## Examples

The repository includes three example programs:

- **hello_world** - Classic "Hello World!" program
  ```bash
  bazel run //examples:hello_world
  ```

- **simple_loop** - Demonstrates basic loops to print "Hello"
  ```bash
  bazel run //examples:simple_loop
  ```

- **beer** - Prints the complete "99 Bottles of Beer" song (warning: outputs 99 verses!)
  ```bash
  bazel run //examples:beer
  ```

## Testing

The repository includes test examples demonstrating the `brainfuck_test` rule:

- **hello_world_test** - Verifies hello_world.bf outputs "Hello World!"
- **simple_loop_test** - Verifies simple_loop.bf outputs correctly
- **print_a_test** - Verifies a simple program that prints "A"

Run all tests:
```bash
bazel test //tests:all
```

Run a specific test:
```bash
bazel test //tests:hello_world_test
```

## License

This project configuration is provided as-is. The brainfuck compiler itself is licensed under its own terms.
