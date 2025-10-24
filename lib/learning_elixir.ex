defmodule LearningElixir do
  @moduledoc """
  Documentation for `LearningElixir`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> LearningElixir.hello()
      :world

  """
  def hello do
    :world
  end

  def start(_type, _args) do
    Mcp.start_mcp()
    {:ok, self()}
  end

  def main(_args) do
    :noop
  end
end
