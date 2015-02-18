defmodule Issues.GithubIssues do
  @user_agent ["User-agent": "Elixir tung@email.com"]
  @github_url Application.get_env(:issues, :github_url)

  # list = Issues.GithubIssues.fetch("elixir-lang", "elixir", 5)
  def fetch(user, project, count) do
    issues_url(user, project)
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

  # def halt_if_bad_payload(list) do
  #   message = Enum.into(list, HashDict.new)["Message"]
  #   if message == "Not Found" do
  #     IO.puts "Not a list returned from the github api.  What was returned:"
  #     IO.inspect list
  #     System.halt(0)
  #   end
  # end
  def convert_to_hash_dict({:ok, list}) do
    # halt_if_bad_payload(list)
    # IO.inspect list
    list |> Enum.map(&(Enum.into(&1, HashDict.new)))
  end
  
  defp issues_url(user, project) do
    url = "#{@github_url}/repos/#{user}/#{project}/issues"
    # IO.inspect url
    url
  end
  
  
end