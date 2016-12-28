# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sermons.Repo.insert!(%Sermons.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Sermons.Repo
alias Sermons.Sermon


sermon = %Sermon{
  ministry_name: "Desiring God",
  passage: "Romans 3:21-26",
  source_url: "http://www.desiringgod.org/messages/god-vindicated-his-righteousness-in-the-death-of-christ",
  download_url: "https://cdn.desiringgod.org/audio/1992/19920315.mp3?1319695290",
  author: "John Piper",
  title: "God Vindicated His Righteousness in the Death of Christ"
  }

Repo.insert!(sermon)
