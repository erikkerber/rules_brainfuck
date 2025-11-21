"""Bazel rules for Brainfuck"""

def _brainfuck_binary_impl(ctx):
    """Implementation of the brainfuck_binary rule."""

    # Get the brainfuck interpreter
    brainfuck_exe = ctx.executable._brainfuck

    # Get the source file
    src = ctx.file.src

    # Create the output executable script
    output = ctx.actions.declare_file(ctx.label.name)

    # Create a wrapper script that runs the brainfuck interpreter
    ctx.actions.write(
        output = output,
        content = """#!/bin/bash
exec "{brainfuck}" "{src}" "$@"
""".format(
            brainfuck = brainfuck_exe.short_path,
            src = src.short_path,
        ),
        is_executable = True,
    )

    # Return the executable and runfiles
    runfiles = ctx.runfiles(files = [brainfuck_exe, src])

    return [
        DefaultInfo(
            executable = output,
            runfiles = runfiles,
        ),
    ]

brainfuck_binary = rule(
    implementation = _brainfuck_binary_impl,
    attrs = {
        "src": attr.label(
            allow_single_file = [".bf", ".b"],
            mandatory = True,
            doc = "The Brainfuck source file to execute",
        ),
        "_brainfuck": attr.label(
            default = Label("//:brainfuck"),
            executable = True,
            cfg = "exec",
            doc = "The Brainfuck interpreter",
        ),
    },
    executable = True,
    doc = """
Compiles and runs a Brainfuck program.

Example:
    brainfuck_binary(
        name = "hello",
        src = "hello.bf",
    )

This creates a runnable target that can be executed with:
    bazel run //:hello
""",
)

def _brainfuck_test_impl(ctx):
    """Implementation of the brainfuck_test rule."""

    # Get the brainfuck interpreter
    brainfuck_exe = ctx.executable._brainfuck

    # Get the source file and expected output
    src = ctx.file.src
    expected_output = ctx.file.expected_output

    # Create the test script
    output = ctx.actions.declare_file(ctx.label.name)

    ctx.actions.write(
        output = output,
        content = """#!/bin/bash
set -e

# Run the brainfuck program and capture output
ACTUAL_OUTPUT=$("{brainfuck}" "{src}")

# Read expected output
EXPECTED_OUTPUT=$(cat "{expected}")

# Compare outputs
if [ "$ACTUAL_OUTPUT" = "$EXPECTED_OUTPUT" ]; then
    echo "PASS: Output matches expected"
    exit 0
else
    echo "FAIL: Output does not match expected"
    echo "Expected:"
    echo "$EXPECTED_OUTPUT"
    echo ""
    echo "Actual:"
    echo "$ACTUAL_OUTPUT"
    exit 1
fi
""".format(
            brainfuck = brainfuck_exe.short_path,
            src = src.short_path,
            expected = expected_output.short_path,
        ),
        is_executable = True,
    )

    # Return the test executable and runfiles
    runfiles = ctx.runfiles(files = [brainfuck_exe, src, expected_output])

    return [
        DefaultInfo(
            executable = output,
            runfiles = runfiles,
        ),
    ]

brainfuck_test = rule(
    implementation = _brainfuck_test_impl,
    attrs = {
        "src": attr.label(
            allow_single_file = [".bf", ".b"],
            mandatory = True,
            doc = "The Brainfuck source file to test",
        ),
        "expected_output": attr.label(
            allow_single_file = [".txt", ".out"],
            mandatory = True,
            doc = "File containing the expected output",
        ),
        "_brainfuck": attr.label(
            default = Label("//:brainfuck"),
            executable = True,
            cfg = "exec",
            doc = "The Brainfuck interpreter",
        ),
    },
    test = True,
    doc = """
Tests a Brainfuck program by comparing its output to expected output.

Example:
    brainfuck_test(
        name = "hello_test",
        src = "hello.bf",
        expected_output = "hello_expected.txt",
    )

This creates a test target that can be executed with:
    bazel test //:hello_test
""",
)
