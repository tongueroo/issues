defmodule GithubIssuesTest do
  use ExUnit.Case
  import Issues.GithubIssues, only: [ sort_asc: 1 ]

  test "sort asc" do
    sorted = Enum.map([[{"created_at", "a"}], [{"created_at", "b"}], [{"created_at", "c"}]], &(Enum.into(&1, HashDict.new)))
    assert sort_asc(fake_list) == sorted
  end

  defp fake_list do
    Enum.map([[{"created_at", "c"}], [{"created_at", "a"}], [{"created_at", "b"}]], &(Enum.into(&1, HashDict.new)))
  end
end