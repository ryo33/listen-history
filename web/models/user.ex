defmodule Musiclog.User do
  use Musiclog.Web, :model
  @derive {Poison.Encoder, only: [
    :id, :name, :display
  ]}

  schema "users" do
    field :name, :string
    field :display, :string
    field :provider, :string
    field :provided_id, :string
    field :api_key, :string

    timestamps()
  end

  @fields [:name, :display, :provider, :provided_id, :api_key]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:name, min: 1, max: 32)
    |> validate_length(:display, min: 1, max: 32)
    |> validate_length(:provider, min: 3)
    |> validate_length(:provided_id, min: 1)
    |> unique_constraint(:name)
    |> unique_constraint(:provided_id)
  end

  def generate_api_key do
    SecureRandom.urlsafe_base64(16)
  end
end
