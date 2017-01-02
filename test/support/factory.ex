defmodule Sermons.Factory do
  use ExMachina.Ecto, repo: Sermons.Repo
  alias Sermons.Sermon

  def sermon_factory do
    %Sermon{
      ministry_name: "Desiring God",
      passage: "Romans 3:21-26",
      source_url: "http://www.desiringgod.org/messages/god-vindicated-his-righteousness-in-the-death-of-christ",
      download_url: "https://cdn.desiringgod.org/audio/1992/19920315.mp3?1319695290",
      author: "John Piper",
      title: "God Vindicated His Righteousness in the Death of Christ",
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

  def with_passage(sermon, passage) do
    %{sermon | passage: passage}
  end
end
