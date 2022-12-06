defmodule CodeCollect.Prefix do
  @moduledoc """
  Generate all possible 2-digit Prefix-Codes
  and check how may points it's worth
  """

  import Extensions.Enum

  @symbols String.graphemes("123456789ABCDEFGHIJKLMNPQRSTUVWXYZ")

  @prefix_points_domain Application.compile_env(:code_collect, [:apis, :prefix])
  @prefix_points_api "#{@prefix_points_domain}/api/public/api/v1/codes/prefix/"

  def get_codes(symbols \\ @symbols) do
    symbols
    |> Enum.map(&add_symbol(&1, symbols))
    |> List.flatten()
    |> pmap(&check_points/1)
  end

  defp add_symbol(char, symbols) do
    symbols
    |> Enum.map(&(char <> &1))
  end

  defp check_points(code) do
    points =
      (@prefix_points_api <> code)
      |> HTTPoison.get()
      |> get_response_body()
      |> get_points()

    {code, points}
  end

  defp get_response_body({:ok, %{body: body}}), do: body
  defp get_response_body(_), do: :error

  defp get_points("{\"points\":0}"), do: 0
  defp get_points("{\"points\":1}"), do: 1
  defp get_points("{\"points\":2}"), do: 2
  defp get_points("{\"points\":3}"), do: 3
  defp get_points("{\"points\":4}"), do: 4
  defp get_points(_), do: :error
end
