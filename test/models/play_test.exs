defmodule Musiclog.PlayTest do
  use Musiclog.ModelCase

  alias Musiclog.Play

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Play.changeset(%Play{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Play.changeset(%Play{}, @invalid_attrs)
    refute changeset.valid?
  end
end
