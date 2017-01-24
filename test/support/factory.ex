defmodule Sermons.Factory do
  use ExMachina.Ecto, repo: Sermons.Repo
  alias Sermons.Sermon
  alias Sermons.Passage

  def sermon_factory do
    %Sermon{
      ministry_name: "Desiring God",
      passage: "Romans 3:21-26",
      source_url: "http://www.desiringgod.org/messages/god-vindicated-his-righteousness-in-the-death-of-christ",
      download_url: "https://cdn.desiringgod.org/audio/1992/19920315.mp3?1319695290",
      author: "John Piper",
      title: "God Vindicated His Righteousness in the Death of Christ",
      slug: "god-vindicated-his-righteousness-in-the-death-of-christ",
      book: "Romans",
      from: 3021,
      to: 3026
      }
  end

  def with_verses(sermon, from, to) do
    sermon |> from_verse(from) |> to_verse(to)
  end

  def from_verse(sermon, from) do
    %{sermon | from: from}
  end

  def to_verse(sermon, to) do
    %{sermon | to: to}
  end

  def with_book(sermon, book) do
    %{sermon | book: book}
  end

  def with_title(sermon, title) do
    %{sermon | title: title}
  end

  def with_passage(sermon, raw_passage) do
    passage = Passage.new(raw_passage)

    %{sermon | passage: raw_passage}
    |> with_verses(passage.from, passage.to)
    |> with_book(passage.book)
  end
end
