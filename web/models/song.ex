defmodule Musiclog.Song do
  use Musiclog.Web, :model
  @derive {Poison.Encoder, only: [
    :name, :album, :artist
  ]}

  schema "songs" do
    field :name, :string
    field :album, :string
    belongs_to :user, Musiclog.User
    belongs_to :artist, Musiclog.Artist

    timestamps()
  end

  @fields [:name, :album, :artist_id, :user_id]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:name, min: 1)
    |> validate_length(:album, min: 1)
  end
end
