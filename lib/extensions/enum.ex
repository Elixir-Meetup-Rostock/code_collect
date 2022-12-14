defmodule Extensions.Enum do
  @moduledoc """
  Extensions for Enum (like a parallel map function)
  """

  @doc """
  Analog to Enum.map, but executed in parallel.
  """
  def pmap(collection, func) do
    collection
    |> Enum.map(&Task.async(fn -> func.(&1) end))
    |> Task.await_many()
  end
end
