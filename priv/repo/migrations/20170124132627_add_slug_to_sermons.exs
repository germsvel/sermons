defmodule Sermons.Repo.Migrations.AddSlugToSermons do
  use Ecto.Migration

  def change do
    alter table :sermons do
      add :slug, :string, null: false
    end

    create unique_index(:sermons, [:slug, :passage])
  end
end
