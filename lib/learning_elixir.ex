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
    {:ok, pid} =
      McpServerState.start_link(%McpServerState.State{
        client_info: %{},
        tools: [
          %{
            "name" => "greeter",
            "title" => "Greeter",
            "description" => "Greets a person very kindly",
            "inputSchema" => %{
              "type" => "object",
              "properties" => %{
                "name" => %{
                  "type" => "string",
                  "description" => "The name of the person to greet"
                }
              },
              "required" => ["name"]
            }
          }
        ]
      })

    Mcp.start_mcp(pid)
    {:ok, self()}
  end

  def main(_args) do
    :noop
  end
end
