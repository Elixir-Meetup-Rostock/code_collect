defmodule CodeCollect.PrefixTest do
  use CodeCollect.DataCase

  alias CodeCollect.Prefix
  alias CodeCollect.Prefix.Server

  @symbols String.graphemes("ABC")

  describe "prefix" do
    setup params do
      on_exit(&Server.stop/0)
      Server.start()

      params
    end

    test "returns all possible prefix codes" do
      prefix_count = length(@symbols) ** 2

      prefix_codes = @symbols |> Prefix.get_codes() |> Enum.uniq()

      assert prefix_count == length(prefix_codes)
    end
  end
end
