defmodule Bex.Responders.Nfl do
  use Hedwig.Responder
  use HTTPoison

  defmodule Game do
    @derive [Poison.Encoder]
    defstruct [:team]
  end

  @scoreboard_url = "http://www.nfl.com/liveupdate/scorestrip/ss.json"
  @game_url = "http://www.nfl.com/liveupdate/game-center/#{gamekey}/#{gamekey}_gtd.json"

  respond ~r/^nfl\s+(?<team>.*)$/i, msg do
    reply msg, get_scores(team)
  end

  defp get_scores(team) do
    case HTTPoison.get(@scoreboard_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!
        |> parse_scores
      _->
        "I encountered an error fetching the scoreboard"
    end
  end

  defp parse_scores(scores) do

  end

end
