defmodule CodeCollect.Prefix.Server do
  use Agent
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  def start do
    Agent.start_link(fn -> Map.new() end, name: __MODULE__)

    Plug.Cowboy.http(__MODULE__, [], port: 5000)
  end

  def stop, do: Plug.Cowboy.shutdown(__MODULE__.HTTP)

  get "/api/public/api/v1/codes/prefix/:code" do
    # conn.params["code"] |> IO.inspect()

    points = :rand.uniform(5) - 1
    response = Jason.encode!(%{points: points})

    Plug.Conn.send_resp(conn, 200, response)
  end
end
