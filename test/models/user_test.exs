defmodule Musiclog.UserTest do
  use Musiclog.ModelCase

  alias Musiclog.User

  @valid_attrs %{display: "some content", name: "some content", provided_id: "some content", provider: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
