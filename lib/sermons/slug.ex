defmodule Sermons.Slug do
  def generate(nil), do: nil
  def generate(string) do
    string
    |> remove_unwanted_chars
    |> String.downcase
    |> String.replace(" ", "-")
  end

  defp remove_unwanted_chars(string) when is_binary(string) do
    valid_chars = []
    valid_pattern = ~r/([a-z]|[0-9]|\s)/i

    String.codepoints(string)
    |> remove_unwanted_chars(valid_pattern, valid_chars)
  end

  defp remove_unwanted_chars([h|t], valid_pattern, valid_chars) do
    if String.match?(h, valid_pattern) do
      remove_unwanted_chars(t, valid_pattern, [h | valid_chars])
    else
      remove_unwanted_chars(t, valid_pattern, valid_chars)
    end
  end

  defp remove_unwanted_chars([], _valid_pattern, valid_chars) do
    valid_chars
    |> Enum.reverse
    |> List.to_string
  end
end
