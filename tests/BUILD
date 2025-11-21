"""Tests for brainfuck programs"""

load("//:defs.bzl", "brainfuck_test")

brainfuck_test(
    name = "hello_world_test",
    src = "//examples:hello_world.bf",
    expected_output = "hello_world_expected.txt",
)

brainfuck_test(
    name = "simple_loop_test",
    src = "//examples:simple_loop.bf",
    expected_output = "simple_loop_expected.txt",
)

brainfuck_test(
    name = "print_a_test",
    src = "print_a.bf",
    expected_output = "print_a_expected.txt",
)
