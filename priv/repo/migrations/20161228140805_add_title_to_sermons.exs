defmodule Sermons.Repo.Migrations.AddTitleToSermons do
  use Ecto.Migration

  def change do
    alter table(:sermons) do
      add :title, :string, default: "Untitled"
    end
  end
end
