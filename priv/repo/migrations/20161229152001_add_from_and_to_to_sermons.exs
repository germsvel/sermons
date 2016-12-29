defmodule Sermons.Repo.Migrations.AddFromAndToToSermons do
  use Ecto.Migration

  def change do
    alter table(:sermons) do
      add :from, :integer, null: false
      add :to, :integer, null: false
      add :book, :string, null: false
    end
  end
end
