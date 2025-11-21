"""Public API for rules_brainfuck"""

load(
    ":brainfuck.bzl",
    _brainfuck_binary = "brainfuck_binary",
    _brainfuck_test = "brainfuck_test",
)

brainfuck_binary = _brainfuck_binary
brainfuck_test = _brainfuck_test
