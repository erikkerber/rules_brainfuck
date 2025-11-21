"""BUILD file for brainfuck compiler"""

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

# Main brainfuck compiler binary
cc_binary(
    name = "brainfuck",
    srcs = [
        "src/brainfuck.c",
        "src/main.c",
        "include/brainfuck.h",
    ],
    includes = [
        "include",
    ],
    copts = [
        "-std=c11",
        "-Wall",
        "-Wextra",
    ],
    defines = [
        "BRAINFUCK_VERSION_MAJOR=2",
        "BRAINFUCK_VERSION_MINOR=7",
        "BRAINFUCK_VERSION_PATCH=3",
    ],
    visibility = ["//visibility:public"],
)

# Library version for embedding
cc_library(
    name = "brainfuck_lib",
    srcs = [
        "src/brainfuck.c",
    ],
    hdrs = [
        "include/brainfuck.h",
    ],
    includes = [
        "include",
    ],
    copts = [
        "-std=c11",
        "-Wall",
        "-Wextra",
    ],
    visibility = ["//visibility:public"],
)
