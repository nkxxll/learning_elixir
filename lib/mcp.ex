defmodule Mcp do
  @moduledoc """
  little module that implements the basic mcp protokol over stdio
  """
  require Logger

  def handle_mcp(%{
        "id" => id,
        "method" => "tools/list"
      }) do

  end

  def handle_mcp(%{
        "id" => id,
        "params" => %{
          "clientInfo" => clientInfo
        },
        "method" => "initialize"
      }) do

    response = %{
      "jsonrpc" => "2.0",
      "id" => id,
      "result" => %{
        "protocolVersion" => "2025-06-18",
        "capabilities" => %{
          "tools" => %{
            "listChanged" => true
          },
          "resources" => %{}
        },
        "serverInfo" => %{
          "name" => "example-server",
          "version" => "1.0.0"
        }
      }
    }

    json = Jason.encode!(response)
    IO.puts(json)
  end

  def handle_mcp(message) do
    Logger.info("message is #{inspect(message)}")
  end

  def start_mcp() do
    message = IO.gets("")
    decoded = Jason.decode(message)

    case decoded do
      {:ok, d} ->
        handle_mcp(d)

      {:error, %Jason.DecodeError{position: pos, token: tok, data: dat}} ->
        Logger.error("There was an error decoding the message pos:#{pos} tok:#{tok} data:#{dat}")
    end
  end
end
