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
    IO.puts("Hello from LearningElixir!")
    {:ok, self()}
  end
end
