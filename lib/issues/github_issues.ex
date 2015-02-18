defmodule Issues.GithubIssues do
  @user_agent ["User-agent": "Elixir tung@email.com"]

  # Issues.GithubIssues.fetch("elixir-lang", "elixir", 5)
  def fetch(user, project, count) do
    o = issues_url(user, project)
      |> HTTPoison.get(@user_agent)
      |> handle_response
    # IO.inspect o
  end

  def handle_response({:ok, %HTTPoison.Response{body: body}}) do
    { :ok, :jsx.decode(body) }
  end

  def handle_response({_, %HTTPoison.Response{body: body}}) do
    { :error, :jsx.decode(body) }
  end

  def convert_to_hash_dict({:ok, list}) do
    # List.first(body) |> Enum.into(HashDict.new)
    list
      |> Enum.map(&(Enum.into(&1, HashDict.new)))
  end
  

  defp issues_url(user, project) do
    url = "https://api.github.com/repos/#{user}/#{project}/issues"
    # IO.inspect url
    url
  end
  
  
end