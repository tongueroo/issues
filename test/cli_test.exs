defmodule CliTest do
  use ExUnit.Case

  import Issues.CLI, only: [ parse_args: 1 ]

  test ":help returned when help flags passed" do
    assert parse_args( ["-h", "blah"]) == :help
    assert parse_args( ["help"]) == :help
    assert parse_args( ["--help"]) == :help
    assert parse_args( ["blah", "-h"]) == :help
  end

  test "help returned not 2 or 3 values passed" do
    assert parse_args(["tongueroo", "hello", "1", "5"]) == :help
    assert parse_args(["tongueroo"]) == :help
  end

  test "three values return if 3 values passed" do
    assert parse_args(["tongueroo", "hello", "1"]) == {"tongueroo", "hello", "1"}
  end

  test "count uses defaults if 2 values passed" do
    assert parse_args(["tongueroo", "hello"]) == {"tongueroo", "hello", "4"}
  end

end