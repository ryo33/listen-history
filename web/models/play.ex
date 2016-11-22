defmodule Musiclog.Play do
  use Musiclog.Web, :model
  @derive {Poison.Encoder, only: [
    :user, :song
  ]}

  schema "plays" do
    belongs_to :user, Musiclog.User
    belongs_to :song, Musiclog.Song

    timestamps()
  end

  @fields [:user_id, :song_id]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
  end

  def preload_params, do: [:user, song: :artist]
end
