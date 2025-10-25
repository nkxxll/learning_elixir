defmodule Mcp do
  @moduledoc """
  little module that implements the basic mcp protokol over stdio
  """
  require Logger

  defp create_content("text", text) do
    %{"type" => "text", "text" => text}
  end

  defp invalid_params(), do: -32602

  defp create_error(code, message) do
    %{"code" => code, "message" => message}
  end

  def handle_mcp(_pid, %{
        "id" => id,
        "method" => "tools/call",
        "params" => %{"name" => "greeter", "arguments" => arguments}
      }) do
    name = Map.fetch(arguments, "name")

    case name do
      {:ok, n} ->
        content = create_content("text", "Greeting fellow human, #{n}")

        response = %{
          "jsonrpc" => "2.0",
          "id" => id,
          "result" => %{
            "content" => content
          }
        }

        json = Jason.encode!(response)
        IO.puts(json)

      :error ->
        json = Jason.encode!(create_error(invalid_params(), "name is not in arguments"))
        IO.puts(json)
    end
  end

  def handle_mcp(pid, %{
        "id" => id,
        "method" => "tools/list"
      }) do
    tools = McpServerState.get_tools(pid)

    response = %{
      "jsonrpc" => "2.0",
      "id" => id,
      "result" => %{
        "tools" => tools
      }
    }

    json = Jason.encode!(response)
    IO.puts(json)
  end

  def handle_mcp(_pid, %{"method" => "notifications" <> notification}) do
    Logger.info("Received Notification: #{notification}")
  end

  def handle_mcp(pid, %{
        "id" => id,
        "params" => %{
          "clientInfo" => clientInfo
        },
        "method" => "initialize"
      }) do
    McpServerState.set_client_info(pid, clientInfo)

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

  def handle_mcp(_pid, message) do
    Logger.info("message is #{inspect(message)}")
  end

  def start_mcp(pid) do
    message = IO.gets("")
    decoded = Jason.decode(message)

    case decoded do
      {:ok, d} ->
        handle_mcp(pid, d)

      {:error, %Jason.DecodeError{position: pos, token: tok, data: dat}} ->
        Logger.error("There was an error decoding the message pos:#{pos} tok:#{tok} data:#{dat}")
    end
  end
end
