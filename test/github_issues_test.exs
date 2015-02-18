defmodule GithubIssuesTest do
  use ExUnit.Case
  import Issues.GithubIssues, only: [ sort_asc: 1,
                                      convert_to_hash_dict: 1 ]

  test "sort asc" do
    list = fake_list(["c", "a", "b"])
    sorted = sort_asc(list)
    letters = for i <- sorted, do: i["created_at"]
    assert letters == ~w{a b c}
  end

  defp fake_list(values) do
    data = for i <- values,
           do: [{"created_at", i}, {"blah", "xxx"}]
    convert_to_hash_dict({:ok, data})
  end
end