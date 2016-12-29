defmodule Sermons.Passage do
  defstruct original: nil, book: nil, from: nil, to: nil

  alias Sermons.Passage
  alias Sermons.Verse

  def new(original) do
    {book, from, to} = parse_original(original)
    %Passage{ original: original,
            book: book,
            from: from,
            to: to }
  end

  defp parse_original(original) do
    {book, rest} = split_book(original)
    {from, to} = split_chapter_and_verses(rest)

    {book, from, to}
  end

  defp split_book(original) do
    case String.split(original, " ") do
      [book, rest] -> {book, rest}
      [book_num, book_name, rest] -> {"#{book_num} #{book_name}", rest}
    end
  end

  defp split_chapter_and_verses(chapter_and_verses) do
    case String.split(chapter_and_verses, ":") do
      [chapter, verses] ->
        parse_chapter_and_verses(chapter, verses)
      [chapter, verse_next_chapter, final_verse] ->
        parse_chapter_and_verses(chapter, verse_next_chapter, final_verse)
    end
  end

  defp parse_chapter_and_verses(chapter, verses) do
    {first, last} = split_verses(verses)

    from = Verse.to_thousand_format(chapter, first)
    to = Verse.to_thousand_format(chapter, last)
    {from, to}
  end

  defp parse_chapter_and_verses(chapter, verse_next_chapter, final_verse) do
    {first_verse, next_chapter} = split_verses(verse_next_chapter)

    from = Verse.to_thousand_format(chapter, first_verse)
    to = Verse.to_thousand_format(next_chapter, final_verse)
    {from, to}
  end

  defp split_verses(verses) do
    case String.split(verses, "-") do
      [first, last] -> {first, last}
      [only_verse] -> {only_verse, only_verse}
    end
  end
end
