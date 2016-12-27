defmodule Sermons.Repo.Migrations.CreateSermon do
  use Ecto.Migration

  def change do
    create table(:sermons) do
      add :ministry_name, :string
      add :passage, :string
      add :source_url, :string
      add :download_url, :string
      add :author, :string

      timestamps()
    end

  end
end
