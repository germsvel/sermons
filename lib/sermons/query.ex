defmodule Sermons.Query do
  defstruct passage: nil, book: nil, chapter: nil, from: nil, to: nil

  alias Sermons.Repo
  alias Sermons.Sermon
  alias Sermons.Query
  alias Sermons.Verse

  def new(passage) do
    {book, from, to} = parse_passage(passage)
    %Query{ passage: passage,
            book: book,
            from: from,
            to: to }
  end

  defp parse_passage(passage) do
    [book, rest] = split_book(passage)
    [from, to] = split_chapter_and_verses(rest)

    {book, from, to}
  end

  defp split_book(passage) do
    case String.split(passage, " ") do
      [book, rest] -> [book, rest]
      [book_num, book_name, rest] -> ["#{book_num} #{book_name}", rest]
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
    [first, last] = split_verses(verses)

    from = Verse.to_thousand_format(chapter, first)
    to = Verse.to_thousand_format(chapter, last)
    [from, to]
  end

  defp parse_chapter_and_verses(chapter, verse_next_chapter, final_verse) do
    [first_verse, next_chapter] = split_verses(verse_next_chapter)

    from = Verse.to_thousand_format(chapter, first_verse)
    to = Verse.to_thousand_format(next_chapter, final_verse)
    [from, to]
  end

  defp split_verses(verses) do
    case String.split(verses, "-") do
      [first, last] -> [first, last]
      [only_verse] -> [only_verse, only_verse]
    end
  end

  def run(_query) do
    Repo.all(Sermon)
  end
end
