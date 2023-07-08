defmodule HighScore do
  @score_initial_value 0

  def new(), do: Map.new()

  def add_player(scores, name, score \\ @score_initial_value) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    Map.put(scores, name, @score_initial_value)
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, fn value -> value + score end)
  end

  def get_players(scores) do
    Map.keys(scores)
  end
end
