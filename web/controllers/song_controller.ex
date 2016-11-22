defmodule Musiclog.SongController do
  use Musiclog.Web, :controller

  alias Musiclog.Song

  def index(conn, _params) do
    query = from song in Song,
      preload: [:artist, :user],
      order_by: [desc: song.updated_at],
      limit: 100
    songs = Repo.all(query)
    render(conn, "index.html", songs: songs)
  end

  def show(conn, %{"id" => id}) do
    query = from song in Song,
      preload: [:artist, :user],
      where: song.id == ^id
    song = Repo.one!(query)
    render(conn, "show.html", song: song)
  end
end
