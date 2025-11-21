"""Example brainfuck programs"""

load("//:defs.bzl", "brainfuck_binary")

brainfuck_binary(
    name = "hello_world",
    src = "hello_world.bf",
)

brainfuck_binary(
    name = "simple_loop",
    src = "simple_loop.bf",
)

brainfuck_binary(
    name = "beer",
    src = "beer.bf",
)

exports_files([
    "hello_world.bf",
    "simple_loop.bf",
    "beer.bf",
])
