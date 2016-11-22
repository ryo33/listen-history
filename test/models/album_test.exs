defmodule Musiclog.AlbumTest do
  use Musiclog.ModelCase

  alias Musiclog.Album

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Album.changeset(%Album{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Album.changeset(%Album{}, @invalid_attrs)
    refute changeset.valid?
  end
end
