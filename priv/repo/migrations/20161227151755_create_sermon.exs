defmodule Sermons.Repo.Migrations.CreateSermon do
  use Ecto.Migration

  def change do
    create table(:sermons) do
      add :ministry_name, :string
      add :passage, :string, null: false
      add :source_url, :string, null: false
      add :download_url, :string
      add :author, :string

      timestamps()
    end

  end
end
