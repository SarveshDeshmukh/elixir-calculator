defmodule Calculator do
  def start do
    spawn(fn-> loop(0) end)
  end

    defp loop(curr_value) do
      new_value = receive do
        {:value, client_id} -> send(client_id,{:response, curr_value})
          # code
          curr_value
        {:add, value} -> curr_value + value
        {:sub, value} -> curr_value - value
        {:mul, value} -> curr_value * value
        {:div, value} -> curr_value / value

        invalid_request -> IO.puts("Invalid Request #{inspect invalid_request}")
        curr_value
      end
      loop(new_value)
      
    end

    def value(server_id) do
      send(server_id,{:value, self()})
      receive do
        {:response, value} -> value
      end
    end

    def add(server_id, value) do
      send(server_id, {:add, value})
      value(server_id)
    end
    def sub(server_id, value) do 
      send(server_id, {:sub, value})
      value(server_id)
    end  
    def mul(server_id, value) do
      send(server_id, {:mul, value})
      value(server_id)
    end
    def div(server_id, value) do
      send(server_id, {:div, value})
      value(server_id)
    end
end