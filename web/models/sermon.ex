defmodule Sermons.Sermon do
  use Sermons.Web, :model

  schema "sermons" do
    field :ministry_name, :string
    field :passage, :string
    field :source_url, :string
    field :download_url, :string
    field :author, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:ministry_name, :passage, :source_url, :download_url, :author])
    |> validate_required([:ministry_name, :passage, :source_url, :download_url, :author])
  end
end
