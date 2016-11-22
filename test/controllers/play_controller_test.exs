defmodule Musiclog.PlayControllerTest do
  use Musiclog.ConnCase

  alias Musiclog.Play
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, play_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing plays"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, play_path(conn, :new)
    assert html_response(conn, 200) =~ "New play"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, play_path(conn, :create), play: @valid_attrs
    assert redirected_to(conn) == play_path(conn, :index)
    assert Repo.get_by(Play, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, play_path(conn, :create), play: @invalid_attrs
    assert html_response(conn, 200) =~ "New play"
  end

  test "shows chosen resource", %{conn: conn} do
    play = Repo.insert! %Play{}
    conn = get conn, play_path(conn, :show, play)
    assert html_response(conn, 200) =~ "Show play"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, play_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    play = Repo.insert! %Play{}
    conn = get conn, play_path(conn, :edit, play)
    assert html_response(conn, 200) =~ "Edit play"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    play = Repo.insert! %Play{}
    conn = put conn, play_path(conn, :update, play), play: @valid_attrs
    assert redirected_to(conn) == play_path(conn, :show, play)
    assert Repo.get_by(Play, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    play = Repo.insert! %Play{}
    conn = put conn, play_path(conn, :update, play), play: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit play"
  end

  test "deletes chosen resource", %{conn: conn} do
    play = Repo.insert! %Play{}
    conn = delete conn, play_path(conn, :delete, play)
    assert redirected_to(conn) == play_path(conn, :index)
    refute Repo.get(Play, play.id)
  end
end
