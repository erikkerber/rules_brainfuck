# Using rules_brainfuck

This guide shows you how to use rules_brainfuck in your own Bazel projects.

## Adding rules_brainfuck to your project

### Option 1: Using this as a local repository

In your `MODULE.bazel`:

```python
local_path_override(
    module_name = "rules_brainfuck",
    path = "../rules_brainfuck",  # Adjust path as needed
)
```

### Option 2: Using from a git repository (when published)

In your `MODULE.bazel`:

```python
bazel_dep(name = "rules_brainfuck", version = "0.0.1")
```

## Using brainfuck_binary in your BUILD files

1. Load the rule in your BUILD file:

```python
load("@rules_brainfuck//:defs.bzl", "brainfuck_binary")
```

2. Define a brainfuck_binary target:

```python
brainfuck_binary(
    name = "my_program",
    src = "my_program.bf",
)
```

3. Run your program:

```bash
bazel run //:my_program
```

## Using brainfuck_test in your BUILD files

1. Load the rule in your BUILD file:

```python
load("@rules_brainfuck//:defs.bzl", "brainfuck_binary", "brainfuck_test")
```

2. Create an expected output file (e.g., `my_program_expected.txt`):

```
Hello World!
```

3. Define a brainfuck_test target:

```python
brainfuck_test(
    name = "my_program_test",
    src = "my_program.bf",
    expected_output = "my_program_expected.txt",
)
```

4. Run your test:

```bash
bazel test //:my_program_test
```

The test will pass if the program output exactly matches the expected output file.

## Complete Example

Here's a complete example of a project using rules_brainfuck:

**MODULE.bazel:**
```python
module(
    name = "my_bf_project",
    version = "0.0.1",
)

bazel_dep(name = "rules_brainfuck", version = "0.0.1")
```

**BUILD:**
```python
load("@rules_brainfuck//:defs.bzl", "brainfuck_binary")

brainfuck_binary(
    name = "hello",
    src = "hello.bf",
)

brainfuck_binary(
    name = "fibonacci",
    src = "fibonacci.bf",
)
```

**Commands:**
```bash
# Run a specific program
bazel run //:hello

# Build all programs
bazel build //...

# Run tests (if you add test targets)
bazel test //...
```

## File Extensions

The `brainfuck_binary` rule accepts files with the following extensions:
- `.bf` (most common)
- `.b` (alternative)

## Advanced Usage

### Multiple programs in subdirectories

```
my_project/
├── MODULE.bazel
├── programs/
│   ├── BUILD
│   ├── hello.bf
│   └── fibonacci.bf
└── examples/
    ├── BUILD
    └── test.bf
```

**programs/BUILD:**
```python
load("@rules_brainfuck//:defs.bzl", "brainfuck_binary")

brainfuck_binary(
    name = "hello",
    src = "hello.bf",
)

brainfuck_binary(
    name = "fibonacci",
    src = "fibonacci.bf",
)
```

Run with:
```bash
bazel run //programs:hello
bazel run //programs:fibonacci
```

## Tips

1. **Program output**: The brainfuck interpreter runs your program and displays output directly to stdout.

2. **Debugging**: If your program doesn't work, test it first with the compiler directly:
   ```bash
   bazel run @rules_brainfuck//:brainfuck -- /path/to/program.bf
   ```

3. **Building without running**: Use `bazel build` to verify your targets compile without executing them:
   ```bash
   bazel build //programs:hello
   ```
