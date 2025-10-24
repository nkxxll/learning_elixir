defmodule Mcp do
  @moduledoc """
  little module that implements the basic mcp protokol over stdio
  """
  require Logger

  def handle_mcp(%{
        "id" => id,
        "params" =>
          %{
            "clientInfo" => clientInfo
          } = params,
        "method" => method
      })
      when method === "initialize" do
    Logger.info("id #{Integer.to_string(id)}")
    Logger.info("clientInfo #{inspect(clientInfo)}")
    Logger.info("params #{inspect(params)}")
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
