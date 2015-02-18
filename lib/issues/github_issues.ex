defmodule Issues.GithubIssues do
  @user_agent ["User-agent": "Elixir tung@email.com"]
  @github_url Application.get_env(:issues, :github_url)

  def github_url2 do
    @github_url2
  end
  

  # list = Issues.GithubIssues.fetch("elixir-lang", "elixir", 5)
  def fetch(user, project, count) do
    o = issues_url(user, project)
      |> HTTPoison.get(@user_agent)
      |> handle_response
      |> convert_to_hash_dict
      |> sort_asc
      |> subset(count)
      |> pretty
  end

  def pretty(list) do
    IO.puts "title created_at"
    for i <- list do
      IO.puts "#{i["title"]} #{i["created_at"]}"
    end
  end

  def subset(list, count) do
    Enum.take(list, count)
  end

  def sort_asc(list) do
    Enum.sort(list, fn(a,b) -> a["created_at"] <= b["created_at"] end)
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
    url = "#{@github_url}/repos/#{user}/#{project}/issues"
    # IO.inspect url
    url
  end
  
  
end