defmodule McpServerState do
  use GenServer

  defmodule State do
    defstruct [:client_info, :tools]
  end

  # client

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def get_client_info(pid) do
    GenServer.call(pid, :get_client_info)
  end

  def get_tools(pid) do
    GenServer.call(pid, :get_tools)
  end

  def set_client_info(pid, client_info) do
    GenServer.cast(pid, {:set_client_info, client_info})
  end

  # server

  @impl true
  @spec init(State) :: {:ok, State} | {:error, String.t()}
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:get_client_info, _from, state) do
    {:reply, state.client_info, state}
  end

  @impl true
  def handle_call(:get_tools, _from, state) do
    {:reply, state.tools, state}
  end

  # this is only one function that has to be supported by the mcp server state to handle the tools state in the mcp server
  # but you have to be able to remove specific tools from the list and so on
  @impl true
  def handle_cast({:add_tool, tool}, state) do
    state = %State{state | tools: [tool | state.tools]}
    {:noreply, state}
  end

  @impl true
  def handle_cast({:set_client_info, client_info}, state) do
    state = %State{state | client_info: client_info}
    {:noreply, state}
  end
end
