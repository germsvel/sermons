defmodule Sermons.Query do
  defstruct passage: nil, book: nil, chapter: nil, first_verse: nil, last_verse: nil

  alias Sermons.Repo
  alias Sermons.Sermon
  alias Sermons.Query
  import String, only: [to_integer: 1]

  def new(passage) do
    {book, chapter, first, last} = parse_passage(passage)
    %Query{ passage: passage,
            book: book,
            chapter: chapter,
            first_verse: first,
            last_verse: last
          }
  end

  defp parse_passage(passage) do
    [book, rest | _] = split_book(passage)
    [chapter, verses | _] = split_chapter(rest)
    [first, last | _] = split_verses(verses)

    {book, to_integer(chapter), to_integer(first), to_integer(last)}
  end

  defp split_verses(verses) do
    case String.split(verses, "-") do
      [first, last | _] -> [first, last]
      [only_verse] -> [only_verse, only_verse]
    end
  end

  defp split_book(passage) do
    String.split(passage, " ")
  end

  defp split_chapter(chapter_and_verses) do
    chapter_and_verses
    |> String.split(":")
  end

  def run(_query) do
    Repo.all(Sermon)
  end
end
