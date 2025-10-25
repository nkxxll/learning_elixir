#!/usr/bin/env bash
initialize='{ "jsonrpc": "2.0", "id": 1, "method": "initialize", "params": { "protocolVersion": "2025-06-18", "capabilities": { "elicitation": {} }, "clientInfo": { "name": "example-client", "version": "1.0.0" } }}'

mix run <<< "$initialize"

notification_initialized='{"jsonrpc": "2.0", "method": "notifications/initialized"}'

mix run <<< "$notification_initialized"

call_tools_list='{ "jsonrpc": "2.0", "id": 2, "method": "tools/list"}'

mix run <<< "$call_tools_list"

call_tool_greet='{ "jsonrpc": "2.0", "id": 3, "method": "tools/call", "params": { "name": "greeter", "arguments": { "name": "tim" } }}'

mix run <<< "$call_tool_greet"

wrong_call_tool_greet='{ "jsonrpc": "2.0", "id": 3, "method": "tools/call", "params": { "name": "greeter", "arguments": { "not a name": "tim" } }}'

mix run <<< "$wrong_call_tool_greet"
