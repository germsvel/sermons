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
    |> cast(params, [:ministry_name, :passage, :source_url, :download_url, :author, :title])
    |> generate_book_fields
    |> generate_slug
    |> validate_required([:ministry_name, :passage, :source_url, :download_url, :author, :title, :from, :to, :book, :slug])
    |> unique_constraint(:slug, name: :sermons_slug_passage_index)
  end

  defp generate_book_fields(changeset) do
    passage = changeset
            |> get_field(:passage)
            |> Sermons.Passage.new

    attrs = %{book: passage.book, from: passage.from, to: passage.to}

    changeset
    |> cast(attrs, [:book, :from, :to])
  end

  defp generate_slug(changeset) do
    slug = changeset
         |> get_field(:title)
         |> Sermons.Slug.generate

    changeset
    |> cast(%{slug: slug}, [:slug])
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
