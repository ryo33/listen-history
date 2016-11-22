defmodule Musiclog.Artist do
  use Musiclog.Web, :model
  @derive {Poison.Encoder, only: [
    :name
  ]}

  schema "artists" do
    field :name, :string
    belongs_to :user, Musiclog.User

    timestamps()
  end

  @fields [:name, :user_id]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:name, min: 1)
    |> unique_constraint(:name)
  end
end
