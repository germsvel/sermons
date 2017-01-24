defmodule Sermons.Sermon do
  use Sermons.Web, :model

  schema "sermons" do
    field :ministry_name, :string
    field :passage, :string
    field :source_url, :string
    field :download_url, :string
    field :author, :string
    field :title, :string
    field :from, :integer
    field :to, :integer
    field :book, :string
    field :slug, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:ministry_name, :passage, :source_url, :download_url, :author, :title, :from, :to, :book])
    |> validate_required([:ministry_name, :passage, :source_url, :download_url, :author, :from, :to, :book])
    |> add_slug
    |> validate_required([:slug])
    |> unique_constraint(:slug, name: :sermons_slug_passage_index)
  end

  defp add_slug(changeset) do
    slug = changeset
         |> get_field(:title)
         |> Sermons.Slug.generate

    changeset
    |> cast(%{slug: slug}, [:slug])
  end

  defp set_passage_data(params) do
    passage = Sermons.Passage.new(params.passage)

    params
    |> Map.put(:book, passage.book)
    |> Map.put(:from, passage.from)
    |> Map.put(:to, passage.to)
  end

  def relevant_sermons(passage) do
    from s in __MODULE__,
      where: (^passage.from >= s.from and ^passage.from <= s.to),
      or_where: (^passage.to > s.from and ^passage.to <= s.to),
      or_where: (^passage.from < s.from and ^passage.to > s.to),
      where: s.book == ^passage.book,
      order_by:  [asc: s.from, asc: s.to]
  end
end
