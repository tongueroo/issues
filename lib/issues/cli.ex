defmodule Issues.CLI do
  @default_count "4"
  @moduledoc """
    Handle the command line parsing
  """

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be -h or --help, which returns :help

  Otherwise it is a github username, project name and number of entries

  Return a tuple of `{ user, project, count }` or `:help` if help was given
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases: [ h: :help ])

    # IO.inspect parse
    case parse do
      { [ help: true ], _, _ }
        -> :help
      { _, [ "help" ], _ }
        -> :help

      { _, [ user, project, count ], _ }
        -> { user, project, count }

      { _, [ user, project ], _ }
        -> { user, project, @default_count }

      _ -> :help
    end
  end
  
  
end